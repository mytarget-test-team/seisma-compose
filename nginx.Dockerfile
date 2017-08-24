# Nginx server image

FROM nginx

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/seisma.conf /etc/nginx/conf.d/seisma.conf

RUN cp -f /usr/share/zoneinfo/Europe/Moscow /etc/localtime
