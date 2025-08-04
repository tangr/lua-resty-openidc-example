FROM openresty/openresty:1.27.1.2-2-alpine-fat
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY main.lua /usr/local/openresty/main.lua
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-openidc 1.8.0-1
