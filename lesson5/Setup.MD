# Steps

Start consul by running :
    `consul agent -dev -client="0.0.0.0"`

Start registrator by running: 
`export hostipaddress=$(hostname -I  | awk '{split($0,a," "); print a[1]}')`

`docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest -ip="$hostipaddress" consul://localhost:8500`

Run echo services (include environment variable `SERVICE_<EXPOSED PORT>_NAME=<service name>` ):

`docker run -d -p 3001:8080 --name echo-bali -e SERVICE_8080_NAME=echo-bali -e SERVICENAME=echo-bali echoservice`

`docker run -d -p 3002:8080 --name echo-fiji -e SERVICE_8080_NAME=echo-fiji -e SERVICENAME=echo-fiji echoservice`

Test is out by running :
`curl localhost:8500/v1/catalog/services`
`curl localhost:8500/v1/catalog/service/echo-bali`

Build openresty image ( change to lesson directory )

`docker build . -t=openresty`

Run openresty image ( include HOSTIP as environment variable )

```
export hostipaddress=$(hostname -I  | awk '{split($0,a," "); print a[1]}')

docker run -d --name=openresty -v /home/kahgeh/dev/learningopenresty/lesson5/config:/etc/nginx/conf.d/ -v /home/kahgeh/dev/learningopenresty/lesson5/app:/app -p 80:80 -e HOSTIP=$hostipaddress openresty
```