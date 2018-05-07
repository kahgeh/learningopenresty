# Purpose

Following tutorial by agentzh - https://openresty.org/download/agentzh-nginx-tutorials-en.html 

Reference - https://github.com/openresty

# Setup

`docker run -d --rm --name=openresty -v /home/kahgeh/dev/learningopenresty:/etc/nginx/conf.d/ -p 80:80 openresty/openresty:alpine`

# Changes
Make changes to default.conf and ask nginx to reload

`docker exec -it openresty nginx -s reload`