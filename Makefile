PWD = $(shell pwd)
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	SED := sed -i ''
else
	SED := sed -i
endif

AWX_TASK = awx_task
AWX_WEB = awx_web
AWX_POSTGRES = postgres
AWX_MEMCACHED = memcached
AWX_RABBITMQ = rabbitmq

include Makefile.variable

ifneq ($(UNAME_S),Darwin)
  ifeq ($(DOCKER_COMPOSE),true)
	AWX_TASK = awx_task_1
	AWX_WEB = awx_web_1
	AWX_POSTGRES = awx_postgres_1
	AWX_MEMCACHED = awx_memcached_1
	AWX_RABBITMQ = awx_rabbitmq_1
  endif
endif
 
all:prerequisite virtual-env ansible-awx docker-install docker-exec

.PHONY: prerequisite
prerequisite:
	pip install virtualenv
	rm -rf ./awx ./Juniper-awx

.PHONY: virtual-env
virtual-env:
	virtualenv Juniper-awx --no-site-packages
	. Juniper-awx/bin/activate && \
	pip install -U pip && \
	pip install ansible docker

.PHONY: ansible-awx
ansible-awx:
	. Juniper-awx/bin/activate && \
	git clone https://github.com/ansible/awx.git
	

.PHONY: docker-install
docker-install:
	. Juniper-awx/bin/activate
ifneq '$(PATH_PROJECTS)' ''
	@${SED} '/project_data_dir/s/^#//g' $(PWD)/awx/installer/inventory
	@${SED} 's|project_data_dir=.*|project_data_dir=$(PATH_PROJECTS)|g' $(PWD)/awx/installer/inventory
endif
ifneq '$(DOCKERHUB_VERSION)' ''
	@${SED} 's/dockerhub_version=.*/dockerhub_version=$(DOCKERHUB_VERSION)/g' $(PWD)/awx/installer/inventory
endif
ifneq '$(POSTGRES_DATA_DIR)' ''
	@${SED} 's|postgres_data_dir=.*|postgres_data_dir=$(POSTGRES_DATA_DIR)|g' $(PWD)/awx/installer/inventory
	@mkdir -p ${POSTGRES_DATA_DIR}/pg_snapshots && touch ${POSTGRES_DATA_DIR}/pg_snapshots/.keep
	@mkdir -p ${POSTGRES_DATA_DIR}/pg_replslot && touch ${POSTGRES_DATA_DIR}/pg_replslot/.keep
	@mkdir -p ${POSTGRES_DATA_DIR}/pg_stat_tmp && touch ${POSTGRES_DATA_DIR}/pg_stat_tmp/.keep
	@mkdir -p ${POSTGRES_DATA_DIR}/pg_stat && touch ${POSTGRES_DATA_DIR}/pg_stat/.keep
	@mkdir -p ${POSTGRES_DATA_DIR}/pg_twophase && touch ${POSTGRES_DATA_DIR}/pg_twophase/.keep
	@mkdir -p ${POSTGRES_DATA_DIR}/pg_tblspc && touch ${POSTGRES_DATA_DIR}/pg_tblspc/.keep
endif
ifneq '$(HOST_FILE)' ''
	cp $(HOST_FILE) $(PWD)/$(PATH_PROJECTS)/hosts
endif
ifeq ($(DOCKER_COMPOSE),true)
	pip install docker-compose
	@${SED} '/use_docker_compose/s/^# //g' $(PWD)/awx/installer/inventory
	@${SED} 's|use_docker_compose=.*|use_docker_compose=$(DOCKER_COMPOSE)|g' $(PWD)/awx/installer/inventory
endif
	ansible-playbook -i $(PWD)/awx/installer/inventory $(PWD)/awx/installer/install.yml
	sleep 30

.PHONY: docker-exec
docker-exec:
ifneq '$(ANSIBLE_GALAXY_JUNOS_VERSION)' ''
	sed 's|ANSIBLE_GALAXY_JUNOS_VERSION|$(ANSIBLE_GALAXY_JUNOS_VERSION)|g' requirements.yml.template > requirements.yml
else
	sed '/ANSIBLE_GALAXY_JUNOS_VERSION/d' requirements.yml.template > requirements.yml
endif
ifneq '$(HOST_FILE)' ''	
	curl -u admin:password --noproxy '*' http://localhost/api/v2/inventories/ --header "Content-Type: application/json" -x POST -d '{"name":"$(INVENTORY_NAME)" , "organization": 1}'
	docker exec -it awx_task /bin/bash -c 'awx-manage inventory_import --source=/var/lib/awx/projects/hosts --inventory-name=$(INVENTORY_NAME) --overwrite'
endif
	docker exec -it $(AWX_TASK) pip install -U pip
	docker exec -it $(AWX_TASK) pip install jsnapy jxmlease junos-eznc
	docker cp requirements.yml $(AWX_TASK):/var/lib/awx/
	docker exec -it $(AWX_TASK) ansible-galaxy install -r requirements.yml -p /etc/ansible/roles
	docker exec -it $(AWX_TASK) /bin/bash -c 'sed -i '/roles_path/s/^#//g' /etc/ansible/ansible.cfg'
	@echo AWX INSTALL IS COMPLETE
	@echo END OF MAKEFILE

.PHONY: docker-stop
docker-stop:
	docker stop $(AWX_TASK)
	docker stop $(AWX_WEB)
	docker stop $(AWX_MEMCACHED)
	docker stop $(AWX_RABBITMQ)
	docker stop $(AWX_POSTGRES)

.PHONY: docker-start
docker-start:
	docker start $(AWX_POSTGRES)
	docker start $(AWX_TASK)
	docker start $(AWX_WEB)
	docker start $(AWX_MEMCACHED)
	docker start $(AWX_RABBITMQ)

.PHONY: docker-remove
docker-remove: docker-stop
	docker rm $(AWX_TASK)
	docker rm $(AWX_WEB)
	docker rm $(AWX_MEMCACHED)
	docker rm $(AWX_RABBITMQ)
	docker rm $(AWX_POSTGRES)

clean: prerequisite
	docker system prune -f
