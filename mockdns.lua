local http = require "resty.http"
local httpc= http.new();
local res, err = httpc:request_uri("http://192.168.5.10:3010/names.json",{
    method = "GET"
})

if not res then
    ngx.say("failed request", err)
end

ngx.status = res.status

ngx.say(res.body)    