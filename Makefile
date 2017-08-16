# seisma management

MAKEFLAGS+=--silent

PROJECT_NAME=seisma

PIP_BIN=pip

GIT_BIN=git

DOCKER_BIN=docker

COMPOSE_BIN=docker-compose

SRC_DIR=$(CURDIR)/src

UI_SRC_PATH=$(SRC_DIR)/$(PROJECT_NAME)-ui

SERVER_SRC_PATH=$(SRC_DIR)/$(PROJECT_NAME)-server

SEISMA_UI_GIT_REPO=https://github.com/trifonovmixail/seisma-ui.git

SEISMA_SERVER_GIT_REPO=https://github.com/trifonovmixail/seisma-server.git


all: install_dependencies install_repositories build install_system_service

install_dependencies:
	$(PIP_BIN) install docker-compose -U --user

install_repositories:
	[ -e "$(UI_SRC_PATH)" ] || $(GIT_BIN) clone $(SEISMA_UI_GIT_REPO) $(UI_SRC_PATH)
	[ -e "$(SERVER_SRC_PATH)" ] || $(GIT_BIN) clone $(SEISMA_SERVER_GIT_REPO) $(SERVER_SRC_PATH)

install_system_service:
	cp -f $(CURDIR)/systemd/seisma.service /usr/lib/systemd/system/seisma.service
	cp -f $(CURDIR)/systemd/default etc/default/seisma
	systemctl enable seisma && systemctl start seisma

up:
	$(COMPOSE_BIN) up

down:
	$(COMPOSE_BIN) down

stop:
	$(COMPOSE_BIN) stop

start:
	$(COMPOSE_BIN) start

restart:
	$(COMPOSE_BIN) restart

reload: down up

status:
	$(DOCKER_BIN) ps -a \
	--filter='name=$(PROJECT_NAME)*' \
	--format='table {{.Names}}\t{{.Status}}\t{{.Ports}}' |\
	grep -v $(PROJECT_NAME)-src

build:
	$(DOCKER_BIN) build --rm --no-cache -t $(PROJECT_NAME)/nginx:latest -f nginx.Dockerfile .
	$(DOCKER_BIN) build --rm --no-cache -t $(PROJECT_NAME)/mysql:latest -f mysql.Dockerfile .
	$(DOCKER_BIN) build --rm --no-cache -t $(PROJECT_NAME)/redis:latest -f redis.Dockerfile .
	$(DOCKER_BIN) build --rm --no-cache -t $(PROJECT_NAME)/frontend:latest -f frontend.Dockerfile .
	$(DOCKER_BIN) build --rm --no-cache -t $(PROJECT_NAME)/backend:latest -f backend.Dockerfile .

logs:
	[ -z "$(s)" ] && $(COMPOSE_BIN) logs --tail="100" -f || $(COMPOSE_BIN) logs --tail="100" -f $(PROJECT_NAME)-$(s)

source_update:
	cd $(SRC_DIR)/$(PROJECT_NAME)-ui && $(GIT_BIN) pull origin master
	cd $(SRC_DIR)/$(PROJECT_NAME)-server && $(GIT_BIN) pull origin master

update: source_update restart
