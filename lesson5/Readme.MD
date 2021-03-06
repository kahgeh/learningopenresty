# Using Consul and Registrator

Instead of using a mock dns, use publicly available service discovery tools like consul. In addition to consul, another tool that is useful is registrator. It automatically registers services with consul when a new container is started

# Familiarize
## consul 
1. Endpoints
- http://<host>:8500/v1/catalog/services/
- http://<host>:8500/v1/catalog/service/<servicename>
  it's possible to also specify filter by tag, e.g.  http://<host>:8500/v1/catalog/service/<servicename>?tag=xxxx 
2. UI - http://<host>:8500/ui/#/dc1/services
3. Customizing registration values like the ServiceName, through environment variables, `SERVICE_<EXPOSED PORT>_NAME=<service name>`

## registrator
1. Customize ServiceAddress in the consul service registration by passing in `-ip="$hostipaddress"` when running registrator

## openresty
1. environment variables are not automatically made available, only environment variables that are declared are made available. e.g. `env HOSTIP;` - this declaration is at the main level( not server or http). refer to the file `/usr/local/openresty/nginx/conf/nginx.conf`
2. use init_worker_by_lua_block, notice how retrieving environment variable using os.getenv will always return nil - this is not an issue if os.getenv is called within a timer (`ngx.timer.at`) 
3. use a timer to perform background task of updating lookup values
4. logs - in order to get notice level logs instead of warn specify notice like this in the conf file: 
   `error_log /spool/logs/all.log notice`
5. use ngx.ctx.<var name>
- in earlier phase like `access_by_lua` set the value 
- access it in the later phase like the content phase

e.g. 
    setting it - `access_by_lua 'ngx.ctx.service = "echo-fiji"';`
    using it   - in `balancer_by_lua_file ( local peer = consul_balancer.next(ngx.ctx.service) )` 


        