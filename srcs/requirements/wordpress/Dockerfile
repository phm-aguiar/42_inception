FROM debian:latest

RUN apt-get update -y && \
    apt-get -y install php-cgi php-mysql mariadb-client wget sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp \
    && chown -R www-data:www-data /var/www/html \
    && useradd -m www-data || true \
    && mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www && chmod -R 755 /var/www

COPY ./tools/wp_config.sh /usr/local/bin/wp_config.sh
RUN chmod +x /usr/local/bin/wp_config.sh

ENTRYPOINT [ "/usr/local/bin/wp_config.sh" ]
	
	
	
	
	
	
	
	
	
	
	
	
	
	# && wget http://wordpress.org/latest.tar.gz -P /var/www/html \
	# && tar -xzvf /var/www/html/latest.tar.gz -C /var/www/html \
	# && rm /var/www/html/latest.tar.gz \
	# && cp -r /var/www/html/wordpress/* /var/www/html \
	# && rm -rf /var/www/html/wordpress \


# wp core download --path=/var/www/html --locale=pt_BR
