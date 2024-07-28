run:
	if [ ! -d ~/mariadb ]; then mkdir ~/mariadb; fi
	if [ ! -d ~/wordpress ]; then mkdir ~/wordpress; fi

prune:
	docker system prune -a -f --volumes

.PHONY: run prune