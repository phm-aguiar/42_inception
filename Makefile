LOGIN=phenriq2
VOLUMES_PATH=/home/${LOGIN}/data
WWW=www.${LOGIN}.42.fr
URL=${LOGIN}.42.fr
export VOLUMES_PATH
export LOGIN
export WWW
export URL

all: clean setup build_no_cache up

setup: host
	if [ ! -d ${VOLUMES_PATH} ]; then sudo rm -rf ${VOLUMES_PATH}; fi
	sudo mkdir -p ${VOLUMES_PATH}
	sudo mkdir -p ${VOLUMES_PATH}/mariadb
	sudo mkdir -p ${VOLUMES_PATH}/wordpress


host:
	@if ! grep -q "${LOGIN}.42.fr" /etc/hosts; then \
		sudo sed -i "2i\127.0.0.1\t${URL}" /etc/hosts; \
		sudo sed -i "2i\127.0.0.1\t${WWW}" /etc/hosts; \
	fi
host-clean:
	sudo sed -i "/${LOGIN}.42.fr/d" /etc/hosts

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
	echo "Operação concluída!"


.PHONY: all setup host host-clean up build build_no_cache down clean

# run:
# 	if [ ! -d ~/mariadb ]; then mkdir ~/mariadb; fi
# 	if [ ! -d ~/wordpress ]; then mkdir ~/wordpress; fi
# 	cd ./srcs && docker-compose up

# prune:
# 	apagar
# 	sudo rm -rf ~/mariadb
# 	sudo rm -rf ~/wordpress

# .PHONY: run prune