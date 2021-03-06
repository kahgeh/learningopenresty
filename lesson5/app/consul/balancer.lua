local _M = {}

local json = require "cjson"
local http = require "resty.http"

local upstreams = {}
local state = {}
local refresh_interval = 30


-- private
local function refresh(premature)
  if premature then
    return
  end
  local host_ip=os.getenv("HOSTIP")
  if host_ip == nil then
    ngx.log(ngx.INFO, "host_ip is empty, waiting to be available...")
    return
  end
  local hc = http:new()
  ngx.log(ngx.INFO, "consul: querying catalog")
  local res, err = hc:request_uri("http://" .. host_ip .. ":8500/v1/catalog/services"), {
    method = "GET"
  }

  if res == nil then
    ngx.log(ngx.ERR, "consul: FAILED to refresh upstreams")
  elseif res.body then

    local suc, services = pcall(function()
      return json.decode(res.body)
    end)

    if suc then
      for service, tags in pairs(services) do
        local sub, err = hc:request_uri("http://" .. host_ip .. ":8500/v1/catalog/service/" .. service , {
          method = "GET"
        })

        if sub.body then
          _M.set(service, json.decode(sub.body))
        end
      end
      ngx.log(ngx.INFO, "consul: refreshed upstreams")
    else
      ngx.log(ngx.ERR, "consul: Failed to decode Consul response")
    end
  end
  
  local ok, err = ngx.timer.at(refresh_interval, refresh)
  if not ok then
    ngx.log(ngx.ERR, "failed to create the timer: ", err)
  end
end

-- public

-- start consul refresh
function _M.start(interval)
  refresh_interval = interval
  
  local ok, err = ngx.timer.at(5, refresh)
  if not ok then
    ngx.log(ngx.ERR, "failed to create the timer: ", err)
  end
end

-- set upstreams
function _M.set(name, nodes)
  upstreams[name] = nodes
end

-- get service nodes
function _M.service(name)
  local nodes = {}
  for index, node in ipairs(upstreams[name]) do
    nodes[index] = {
      address = node["ServiceAddress"],
      port = node["ServicePort"]
    }
  end

  return nodes
end

-- get next node saving state per service
function _M.next(service)
  if upstreams[service] == nil then
    return nil
  end

  if state[service] == nil or state[service] > #upstreams[service] then
    state[service] = 1
  end

  local node = upstreams[service][state[service]]
  state[service] = state[service] + 1

  return {
    address = node["ServiceAddress"],
    port = node["ServicePort"]
  }
end

return _M