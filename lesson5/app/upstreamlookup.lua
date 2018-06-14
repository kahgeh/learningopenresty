local balancer = require "ngx.balancer"
local consul_balancer = require "consul.balancer"

local peer = consul_balancer.next(ngx.ctx.service)
ngx.log(ngx.NOTICE, "service " .. ngx.ctx.service)
if peer == nil then
    ngx.log(ngx.ERR, "no peer found for service: ", ngx.ctx.service)
    return ngx.exit(500)
end

local ok,err = balancer.set_current_peer(peer["address"], peer["port"])
if not ok then 
    ngx.log(ngx.ERR, "failed to set the current peer")
    return ngx.exit(500)
end