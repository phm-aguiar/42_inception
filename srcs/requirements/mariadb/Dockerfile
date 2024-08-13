FROM debian:bookworm


RUN apt-get update && apt-get install -y mariadb-server

COPY ./config/mdb.sh /mdb.sh

RUN chmod +x /mdb.sh

ENTRYPOINT ["./mdb.sh"]