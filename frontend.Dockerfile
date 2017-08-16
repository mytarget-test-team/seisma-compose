# Nodejs image

FROM node:6.3.1

COPY init.d/frontend /opt/entry_point

WORKDIR /usr/local/src/seisma-ui
