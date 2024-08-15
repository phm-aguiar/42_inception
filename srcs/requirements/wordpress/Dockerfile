FROM debian:oldstable

WORKDIR /var/www/html/

RUN apt update -y && \
    apt install php7.4 php-fpm php-mysql mariadb-client wget -y && \
	wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp \
	&& wp core download --allow-root --path=/var/www/html \
	&& mkdir /run/php 
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/wp_config.sh /tmp/wp_setup.sh

RUN chmod 755 /var/www && chown -R www-data:www-data /var/www && chmod +x /tmp/wp_setup.sh

ENTRYPOINT ["/tmp/wp_setup.sh"]
    

