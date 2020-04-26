.DEFAULT_GOAL:=help

help:
	@echo Make goals to manage this environment
	@echo 1. make up: Starts the containers, creates volumes and a authentication key for grafana
	@echo 2. make up-logs: Same as "up" but runs attached so you can see the logs of the containers
	@echo 3. make stop: To stop the containers when the environment was started using "make up"
	@echo 4. make down: To cleanup everything, will: remove the volumes created for the containers remove the grafana key, use it to reset the environment

up: 
	@docker-compose up --build -d

up-logs:
	@docker-compose up --build

stop:
	@docker-compose stop

down:
	@docker-compose down && \
	rm boards/key/key || true

.PHONY: up down help
