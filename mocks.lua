local json = require "cjson"
require 'enumerable'


Dns = {names={}}

function Dns:retrieve()
    local http = require "resty.http"
    local httpc= http.new();  
    local res, err = httpc:request_uri("http://192.168.5.10:3010/names.json",{
       method = "GET"
    })
    if not res then
        return nil
    end
    self.names=Enumerable:new(json.decode(res.body))
    return 

end

function Dns:lookup(name)    
    return self.names
            :filter(function(value,index) return value['name'] == name end )
            :first(function (item) return item.address end )       
end


function Dns:new(t)
    t=t or {}
    setmetatable(t,self)
    self.__index = self
    return t
end

return {
    Dns=Dns
}


