FROM debian:bookworm


WORKDIR /var/www/html/

RUN apt update -y && \
    apt upgrade -y && \
    apt install php php-fpm php-mysql mariadb-client wget sudo -y

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp \
	&& wp core download --allow-root --path=/var/www/html

RUN mkdir -p /run/php

RUN chown -R www-data:www-data /var/www/html \
	&& chmod 755 /var/www/html

COPY config/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/wp_config.sh /tmp/wp_config.sh

RUN chmod +x /tmp/wp_config.sh

ENTRYPOINT ["/tmp/wp_config.sh"]
    

