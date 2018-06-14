require 'resty.core'
local lrucache = require "resty.lrucache"
local cache, err = lrucache.new(200)  -- allow up to 200 items in the cache
if not cache then
    return error("failed to create the cache: " .. (err or "unknown"))
end

local mocks=require 'mocks'
local dns = mocks.Dns:new()
dns:retrieve{ngx_init_phase=true}
ngx.log(ngx.NOTICE, "bali :".. dns:lookup('echo-bali')) 
local mocksDict =ngx.shared.mocks
mocksDict:set('dns',dns:tojson())
local jsontext,err=mocksDict:get('dns')
retrieveDns=mocks.Dns:fromjson(jsontext)
ngx.log(ngx.NOTICE, "fiji :".. retrieveDns:lookup('echo-fiji')) 
