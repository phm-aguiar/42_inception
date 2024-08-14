LOGIN=luizedua
COMPOSE_FILE=./srcs/docker-compose.yml
COMPOSE_CMD=docker-compose -f $(COMPOSE_FILE)
VOLUMES= /home/$(LOGIN)/data/mariadb \
		 /home/$(LOGIN)/data/wordpress \

all: up

setup:
	@if [ ! -d /home/$(LOGIN)/data ]; then \
		echo "Creating directory for data volume."; \
		sudo mkdir -p $(VOLUMES); \
	fi

	@if [ ! -f ./srcs/.env ]; then \
		echo "No .env file."; \
	fi
	
	@if ! grep -q $(LOGIN) /etc/hosts; then \
		echo "Adding $(LOGIN).42.fr to hosts file."; \
		echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi

up: setup
	$(COMPOSE_CMD) up -d

down:
	$(COMPOSE_CMD) down

clean: 
	docker image prune -af

fclean: down volume-cleaner
	docker system prune -af

re: fclean all

volume-cleaner:
	sudo rm -rf /home/$(LOGIN)/data
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
		else echo "No volumes to remove"; \
	fi

.PHONY: all setup up down clean fclean re volume-cleaner