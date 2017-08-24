# Nodejs image

FROM node:6.3.1

RUN cp -f /usr/share/zoneinfo/Europe/Moscow /etc/localtime

COPY init.d/frontend /opt/entry_point

WORKDIR /usr/local/src/seisma-ui
