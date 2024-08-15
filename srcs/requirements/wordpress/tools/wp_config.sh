#!/bin/bash

check_db() {
  echo "Verificando a conectividade com o banco de dados em ${WORDPRESS_DB_HOST}..."
  mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "show databases;" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Conexão com o banco de dados bem-sucedida."
    return 0
  else
    echo "Falha ao conectar ao banco de dados."
    return 1
  fi
}

until check_db; do
  echo "Aguardando o banco de dados estar disponível..."
  sleep 5
done
wp config create \
    --allow-root \
    --path=/var/www/html \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST} \
    --locale=pt_BR

wp core install \
    --allow-root \
    --path=/var/www/html \
    --url=${WP_URL} \
    --title="${WP_TITLE}" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL}

wp user create \
    --allow-root \
    "${WP_VIWER_USER}" "${WP_VIWER_EMAIL}" \
    --role=subscriber \
    --user_pass="${WP_VIWER_PASSWORD}" \
    --path=/var/www/html

exec php-fpm7.4 -F

