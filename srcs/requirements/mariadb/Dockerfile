FROM debian:latest

RUN apt-get update && apt-get install -y mariadb-server

COPY ./tools/setup_db.sh /tmp/setup_db.sh
RUN chmod +x /tmp/setup_db.sh && bash /tmp/setup_db.sh

COPY ./conf/my.cnf /etc/mysql/my.cnf

CMD ["mysqld_safe"]