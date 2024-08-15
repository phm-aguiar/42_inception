FROM debian:oldstable


RUN apt-get update && apt-get install -y mariadb-server \
    && mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

COPY ./conf/mdb.sh /mdb.sh

RUN chmod +x /mdb.sh

ENTRYPOINT ["./mdb.sh"]