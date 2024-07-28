FROM debian:latest

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/setup_db.sh /tmp/setup_db.sh

RUN chmod +x /tmp/setup_db.sh && bash /tmp/setup_db.sh

EXPOSE 3306

CMD ["mysqld_safe"]