# Path for lua files

`/usr/local/openresty/lualib`


# Key References

## Directives

Know the phases by looking at this diagram 

https://cloud.githubusercontent.com/assets/2137369/15272097/77d1c09e-1a37-11e6-97ef-d9767035fc3e.png


e.g. inity_by_lua, content_by_lua and corresponding  _by_lua_file ( to help keep code out of configs )

https://github.com/openresty/lua-nginx-module/blob/master/README.markdown#directives



# Libraries 

https://github.com/bungle/awesome-resty

lua-resty-socket



## API 

e.g. ngx.say, ngx.req.get_headers

https://github.com/openresty/lua-nginx-module/blob/master/README.markdown#nginx-api-for-lua

# Other Notes
dynamic upstream : https://github.com/yzprofile/ngx_http_dyups_module