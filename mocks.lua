local json = require "cjson"

Enumerable = {items={}}

function Enumerable:append(value)
    self.items[#self.items+1]=value
end

function Enumerable:filter(predicate)
    local result=Enumerable:new()
    for index,value in ipairs(self.items) do
        if(predicate(value,index)) then
            result:append(value)
        end
    end
    return result
end

function Enumerable:first(expandproperty)
    if #self.items < 1 then
        return nil
    end
    
    if expandproperty ~= nil then 
        return expandproperty(self.items[1])
    end

    return self.items[1]
end

function Enumerable:new(t)
    if t ~= nil then
        t={items=t}
    else
        t={items={}}
    end
    setmetatable(t,self)
    self.__index = self
    return t    
end

Dns = {names={}}
--[[
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
]]

function Dns:retrieve()
    local file = io.open("mockdns/app/public/names.json")
    self.names=Enumerable:new(json.decode(file:read("*a") ))
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


