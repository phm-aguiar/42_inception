#!/bin/bash

# Definindo a estrutura de diretórios e arquivos
dirs=(
    "srcs"
    "srcs/requirements"
    "srcs/requirements/bonus"
    "srcs/requirements/mariadb"
    "srcs/requirements/mariadb/config"
    "srcs/requirements/mariadb/tools"
    "srcs/requirements/nginx"
    "srcs/requirements/nginx/config"
    "srcs/requirements/nginx/tools"
    "srcs/requirements/wordpress"
    "srcs/requirements/wordpress/config"
    "srcs/requirements/wordpress/tools"
)

files=(
    "Makefile"
    "srcs/docker-compose.yml"
    "srcs/.env"
    "srcs/requirements/mariadb/Dockerfile"
    "srcs/requirements/mariadb/.dockerignore"
    "srcs/requirements/nginx/Dockerfile"
    "srcs/requirements/nginx/.dockerignore"
    "srcs/requirements/wordpress/Dockerfile"
)

# Criando os diretórios
for dir in "${dirs[@]}"; do
    mkdir -p "$dir"
done

# Criando os arquivos
for file in "${files[@]}"; do
    touch "$file"
done

echo "Estrutura de diretórios e arquivos criada com sucesso!"
