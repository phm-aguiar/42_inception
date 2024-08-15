LOGIN=phenriq2
VOLUMES_PATH=/home/${LOGIN}/data
URL=${LOGIN}.42.fr
export VOLUMES_PATH
export LOGIN
export URL

all: clean setup build_no_cache up

setup: host
	if [ ! -d ${VOLUMES_PATH} ]; then sudo rm -rf ${VOLUMES_PATH}; fi
	sudo mkdir -p ${VOLUMES_PATH}
	sudo mkdir -p ${VOLUMES_PATH}/mariadb
	sudo mkdir -p ${VOLUMES_PATH}/wordpress


host:
	sudo chmod 666 /etc/hosts
	@if ! grep -q 'phenriq2' /etc/hosts; then \
		sudo echo '127.0.0.1 phenriq2.42.fr' >> /etc/hosts; \
	fi

up:
	cd srcs && docker-compose up -d
build:
	cd srcs && docker-compose build

build_no_cache:
	cd srcs && docker-compose build --no-cache

down:
	cd srcs && docker-compose down

clean: down
	if [ -d ${VOLUMES_PATH} ]; then sudo rm -rf ${VOLUMES_PATH}; fi
	if [ $(docker ps -q) ]; then docker stop $(docker ps -q); fi
	if [ $(docker ps -aq) ]; then docker rm $(docker ps -aq); fi
	if [ $(docker images -q) ]; then docker rmi $(docker images -q); fi
	if [ $(docker volume ls -q) ]; then docker volume rm $(docker volume ls -q); fi
	if [ $(docker network ls -q) ]; then docker network rm $(docker network ls -q); fi
	docker system prune -a --volumes
	echo "Operação concluída!"


.PHONY: all setup host host-clean up build build_no_cache down clean
