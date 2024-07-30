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

sudo -u www-data wp core download --path=/var/www/html --locale=pt_BR

sudo -u www-data wp config create \
    --path=/var/www/html \
    --dbname=${WORDPRESS_DB_NAME} \
    --dbuser=${WORDPRESS_DB_USER} \
    --dbpass=${WORDPRESS_DB_PASSWORD} \
    --dbhost=${WORDPRESS_DB_HOST} \
    --locale=pt_BR

# Instalar o WordPress
sudo -u www-data wp core install \
    --path=/var/www/html \
    --url=${WP_URL} \
    --title="${WP_TITLE}" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL}

# Adicionar um novo usuário não administrativo
sudo -u www-data wp user create \
    ${WP_NO_ADMIN_USER} ${WP_NO_ADMIN_EMAIL} \
    --path=/var/www/html \
    --user_pass=${WP_NO_ADMIN_PASSWORD} \
    --role=subscriber

chown -R www-data:www-data /var/www/html

exec php-cgi -b 0.0.0.0:9000