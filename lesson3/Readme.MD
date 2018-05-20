# Purpose 
1. Learn to code using  object oriented style referencing 
2. Learn about modularizing using modules

# Course Sub-Objectives
Better structure code to be able to do a look up with a simple call like this `dns:lookup("echo-fiji")`

# Pre-requisites

0. lua 5.2
1. cjson - use apt install, then copy `/usr/lib/x86_64-linux-gnu/lua/5.2/cjson.so` to `/usr/local/lib/lua/5.2`
2. penlight pretty printing - use luarocks 


# Familiarize 

1. object oriented style referencing `:`, simple makes `self` available to the function attached to the table

```
    Dns = {names={}}
    
    function Dns:retrieve()
        local file = io.open("mockdns/app/public/names.json")
        self.names=Enumerable:new(json.decode(file:read("*a") ))
    end
```
2. meta table

```
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
```

3. Count operator `#`, example

```
    if #self.items < 1 then
            return nil
    end
```

```
    self.items[#self.items+1]=value
```
# Lesson Objectives

1. Implement `Enumerable` type with the following methods:
- new
- append
- filter
- first

2. Implement `Dns` type with the following methods :
- new
- retrieve
- lookup