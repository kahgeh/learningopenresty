local json = require "cjson"

Enumerable = {items={}}

function Enumerable:append(value)
    self.items[#self.items+1]=value
end

function Enumerable:tojson()
    return json.encode(self.items)
end

function Enumerable:fromjson(jsontext)
    self.items=json.decode(jsontext)
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