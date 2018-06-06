# Purpose

Following tutorial by agentzh - https://openresty.org/download/agentzh-nginx-tutorials-en.html 

Reference - https://github.com/openresty

# Setup

`docker run -d --name=openresty -v /home/kahgeh/dev/learningopenresty/config:/etc/nginx/conf.d/ -v /home/kahgeh/dev/learningopenresty/app:/app -p 80:80 openresty`

# Changes
Make changes to default.conf and ask nginx to reload

`docker exec -it openresty nginx -s reload`