COMPOSE_FILE := "docker-compose.yml"

THIS_FILE := $(lastword $(MAKEFILE_LIST))
.PHONY: help all build up start down destroy stop restart run updestroy logs ps stats
help: ### Shows this help
	@awk 'BEGIN {FS = ":.*###"; printf "make \033[36m<command>\033[0m [c=image-name]\n\nUsage:\033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?###/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^###@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
##
all: ### Builds and runs specified flag or all image solutions
	make build c=$(c)
	make up c=$(c)
build: ### Builds the images
	docker-compose -f $(COMPOSE_FILE) build $(c)
up: ### Brings up a dormant container in detached mode
	docker-compose -f $(COMPOSE_FILE) up --force-recreate -d $(c)
start: ### Starts a container
	docker-compose -f $(COMPOSE_FILE) start $(c)
down: ### Brings down a running container
	docker-compose -f $(COMPOSE_FILE) down $(c)
stop: ### Stops specified container
	docker-compose -f $(COMPOSE_FILE) stop $(c)
rm: ### Destroys specified container
	docker-compose -f $(COMPOSE_FILE) down -v $(c)
restart: ### Restarts specified container
	make stop c=$(c); make up c=$(c)
updestroy: ### Brings up a container and destroys it afterwards
	docker-compose -f $(COMPOSE_FILE) up $(c); docker-compose -f $(COMPOSE_FILE) down -v $(c)
logs: ### Bring up logs for app
	docker-compose -f $(COMPOSE_FILE) logs --tail=100 -f $(c)
ps: ### Shows running containers
	docker-compose -f $(COMPOSE_FILE) ps
