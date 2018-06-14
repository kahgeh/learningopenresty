FROM openresty/openresty:alpine
RUN mkdir -p /spool/logs
RUN sed -i '10 a env HOSTIP;' /usr/local/openresty/nginx/conf/nginx.conf