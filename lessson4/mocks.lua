local json = require "cjson"
require 'enumerable'
local host='192.168.5.10'
local port='3010'
local path= '/names.json'

Dns = {names={}}

-- function Dns:retrieve()
--     local http = require "resty.http"
--     local httpc= http.new();  
--     local res, err = httpc:request_uri("http://192.168.5.10:3010/names.json",{
--        method = "GET"
--     })
--     if not res then
--         return nil
--     end
--     self.names=Enumerable:new(json.decode(res.body))
--     return 

-- end

function Dns:retrieveusingluasockets()
    local socket = require("socket")
    local http = require("socket.http")
    local url = require("socket.url")
    local ltn12 = require("ltn12")
    local lrucache = require "resty.lrucache"
    http.TIMEOUT = 10
    local t = socket.gettime()
    local request={
        url="http://".. host .. ":" .. port .. path
    }

    if not request.sink then request.sink, t = ltn12.sink.table() end
    request.source = request.source or
        (request.body and ltn12.source.string(request.body))
    local response = {}
    
    local code,status,headers,message =http.request(request)
    if t and #t > 0 then body = table.concat(t) end
    self.names=Enumerable:new(json.decode(body))
end

function Dns:tojson()
    return self.names:tojson()
end

function Dns:retrieveusingrestyhttp()
    local http = require "resty.http"
    local res, err = http.request(host, port, { 
       method = "GET",
       path=path
    })

    if not res then
        return nil
    end
    self.names=Enumerable:new(json.decode(res.body))
    return 
end

function Dns:retrieve(params)
    params = params or {}
    options = {
      ngx_init_phase = false
    }
    
    for k,v in pairs(params) do options[k] = v end
    inNgxInitPhase = options.ngx_init_phase
    if not inNgxInitPhase then
        self:retrieveusingrestyhttp()
        return 
    end

    self:retrieveusingluasockets()
end


function Dns:lookup(name)    
    return self.names
            :filter(function(value,index) return value['name'] == name end )
            :first(function (item) return item.address end )       
end


function Dns:new(t)
    if t ~= nil then
        t={names=t}
    else
        t={names={}}
    end
    setmetatable(t,self)
    self.__index = self
    return t
end

function Dns:fromjson(jsontext)
    t={names=Enumerable:new(json.decode(jsontext))}
    setmetatable(t,self)
    self.__index = self
    return t
end

return {
    Dns=Dns
}


