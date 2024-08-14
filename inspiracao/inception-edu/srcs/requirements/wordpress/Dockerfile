FROM debian:oldstable

RUN apt update && apt install -y wget\
	lsb-release
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg\
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list\
	&& apt update \
	&& apt install -y php7.3 \
	php7.3-fpm\ 
	php7.3-mysql \
	mariadb-client \
	vim


RUN wget https://wordpress.org/latest.tar.gz -P var/www \
	&& cd /var/www && tar -xvf latest.tar.gz && rm latest.tar.gz \
	&& chown -R root:root /var/www/wordpress
COPY /conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp-config.php /var/www/wordpress/wp-config.php
COPY conf/auto-config.sh /auto-config.sh
RUN chmod +x /auto-config.sh && mkdir /run/php && ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm
ENTRYPOINT [ "./auto-config.sh" ]