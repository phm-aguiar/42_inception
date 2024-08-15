FROM debian:oldstable

RUN apt-get update && apt-get install -y nginx openssl && \
    openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -out /etc/ssl/certs/phenriq2.42.fr.crt -keyout \
    /etc/ssl/certs/phenriq2.42.fr.key -subj "/C=BR/ST=SP/L=SP/O=42/OU=42SP/CN=domain_name.fr/UID=admin"

COPY ./conf/nginx.conf /etc/nginx/conf.d

ENTRYPOINT ["nginx", "-g", "daemon off;"]
