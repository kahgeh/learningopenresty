_M = {}
local json = require "cjson"

function _M.lookup(name)
    local http = require "resty.http"
    local httpc= http.new();  
    local res, err = httpc:request_uri("http://192.168.5.10:3010/names.json",{
        method = "GET"
    })


    if not res then
        return nil
    end
    ngx.status = res.status
    names=json.decode(res.body)
    
    return 
end

return _M