# Purpose 
Learn how we can use `balancer_by_lua_block` to dynamically determine the address upstream  

# Sub-Objectives
Learn how to use `init_by_lua_file` and observe how certain libraries such as resty.http can only be used within phases involving a request

Explore options to use non-resty libraries through the use of lua libraries installed via luarocks

# Familiarize 

1. docker image capable of using luarocks - openresty/openresty:alpine-fat
2. alpine images lacks glibc which luasocket uses, see the Dockerfile 
3. use shared cache e.g. `lua_shared_dict mocks 10m;`, understand that it only supports basic types string, number and not table
4. using luasocket 
   - install using luarocks, using the alpine-fat image, search path for the .so file is correctly configured, however the lua files is missing so 
     i) retrieve from https://github.com/diegonehab/luasocket/tree/master/src
     ii) and reference it like this `lua_package_path "/app/socket/?.lua;/app/?.lua;/app/resty/?.lua;;";`  
   - see in `retrieveusingluasockets` mocks.lua