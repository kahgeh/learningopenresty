-- learn how to manipulate object, filter
local cjson = require "cjson"
local pl = require 'pl.pretty'

local file = io.open("mockdns/app/public/names.json")

function filter(enumerable, predicate)
    local result={}
    for index,value in ipairs(enumerable) do
        if(predicate(value,index)) then
            result[#result+1]=value
        end
    end
    return result
end

function lookup(name, names )
    local result=filter(names, function(value,index) return value['name'] == name end )
    
    if #result > 0  then
        return result[1].address
    end      
    return nil
end

print (lookup('echo-fiji', cjson.decode(file:read("*a") )) )

