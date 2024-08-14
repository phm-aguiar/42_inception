FROM debian:oldstable

ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD


RUN apt-get update && apt-get install -y mariadb-server vim

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./conf/scriptDB.sh /scriptDB.sh

RUN mkdir -p /var/run/mysqld && mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld \
	&& chmod 777 /run/mysqld \
	&& chmod +x ./scriptDB.sh
RUN ./scriptDB.sh
CMD [ "mysqld_safe" ]
# ENTRYPOINT [ "bash" ]