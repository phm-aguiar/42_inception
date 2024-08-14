#!/bin/bash

if [ -f /var/www/wordpress/wp-config-sample.php ]; then
	rm -rf /var/www/wordpress/wp-config-sample.php
	wp core install --allow-root \
		--path=/var/www/wordpress \
		--title="Inception" \
		--url=$DOMAIN_NAME \
		--admin_user=$WP_ROOT_USER \
		--admin_password=$WP_ROOT_PASSWORD \
		--admin_email=$WP_ROOT_EMAIL

	wp user create --allow-root	\
		--path=/var/www/wordpress \
		"$WP_USER" "$WP_EMAIL" \
		--user_pass=$WP_PASSWORD \
		--role='author'
fi

exec php-fpm -F