FROM openresty/openresty
RUN mkdir -p /usr/local/lib/resty
RUN mkdir -p /spool/logs
ADD ./lualib/http.lua /usr/local/lib/resty/
ADD ./lualib/http_headers.lua /usr/local/lib/resty/
ADD nginx.conf /etc/nginx/conf.d/