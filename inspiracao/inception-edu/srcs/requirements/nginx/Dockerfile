FROM debian:oldstable

RUN apt update && apt install -y nginx \
	vim \
	wget \
	openssl

RUN mkdir -p /etc/nginx/ssl && mkdir -p /var/www/html

RUN openssl req -x509 -nodes \
	-out etc/nginx/ssl/nginx-selfsigned.crt \
	-keyout etc/nginx/ssl/nginx-selfsigned.key \
	-subj "/C=BR/ST=SP/L=Sao Paulo/O=42/OU=42Student/CN=luizedua.42.fr"

COPY ./config/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT [ "nginx" ]
CMD [ "-g", "daemon off;" ]