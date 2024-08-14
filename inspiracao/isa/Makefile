VOLUME_PATH=/home/igenial/data
COMPOSE=./srcs/docker-compose.yml
DOT_ENV=https://gist.githubusercontent.com/IsabelaGenial/b724206c5cb409a9d15c818666986bf6/raw/42d2e99504f51357553cb5cad4b25ae9887552bb/.env

all: permission config up
.PHONY: all

permission:
	@/usr/bin/echo -e '\033[1;33mSUDO PERMISSION!\033[0m'
	@sudo /usr/bin/echo -e '\033[1;31mWORKING\033[0m'
.PHONY: permission

config:
	@if [ ! -f ./srcs/.env ]; then \
		wget -O ./srcs/.env ${DOT_ENV}; \
	fi
	@sudo chmod 666 /etc/hosts
	@if ! grep -q 'igenial' /etc/hosts; then \
		sudo echo '127.0.0.1 igenial.42.fr' >> /etc/hosts; \
	fi
	@if [ ! -d "${VOLUME_PATH}/wordpress-db" ]; then \
		sudo mkdir -p ${VOLUME_PATH}/wordpress-db; \
	fi
	@if [ ! -d "${VOLUME_PATH}/mariadb-db" ]; then \
		sudo mkdir -p ${VOLUME_PATH}/mariadb-db; \
	fi
.PHONY: config

up:
	@if [ -z "$$(docker-compose -f ${COMPOSE} ps 2> /dev/null | grep Up)" ]; then \
		docker-compose -f ${COMPOSE} up; \
	else \
		echo "There is containers up, please KILL them :)"; \
	fi
.PHONY: up

down:
	@if [ -n "$$(docker-compose -f ${COMPOSE} images -q 2> /dev/null)" ]; then \
		docker-compose -f ${COMPOSE} down; \
	else \
		echo "No images to delete!"; \
	fi
.PHONY: down

prune: down
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi
	@sudo rm -fr ${VOLUME_PATH}/*
	@docker system prune -f -a
.PHONY: prune

re: prune all
.PHONY: re