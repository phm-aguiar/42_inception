run:
	if [ ! -d ~/mariadb ]; then mkdir ~/mariadb; fi
	if [ ! -d ~/wordpress ]; then mkdir ~/wordpress; fi
	cd ./srcs && docker-compose up

prune:
	apagar
	sudo rm -rf ~/mariadb
	sudo rm -rf ~/wordpress

.PHONY: run prune