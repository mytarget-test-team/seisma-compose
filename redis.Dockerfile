# Redis server image

FROM redis:3.2.8

RUN cp -f /usr/share/zoneinfo/Europe/Moscow /etc/localtime
