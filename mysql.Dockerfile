# MySQL server image

FROM mariadb:5.5.53

ENV MYSQL_ALLOW_EMPTY_PASSWORD 1

COPY etc/mysql/my.cnf /etc/mysql/my.cnf

RUN cp -f /usr/share/zoneinfo/Europe/Moscow /etc/localtime
