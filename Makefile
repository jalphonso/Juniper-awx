all:prequisite virtual-env ansible-awx playbook docker ## install juniper-awx
PWD = $(shell pwd)

include Makefile.variable
 
.PHONY: prequisite
prequisite:
	pip install virtualenv
	rm -rf ./awx ./Juniper-awx $(PWD)/$(PATH_PROJECTS)        
	mkdir -p $(PWD)/$(PATH_PROJECTS)
	
.PHONY: virtual-env
virtual-env:
	virtualenv Juniper-awx --no-site-packages
	. Juniper-awx/bin/activate && \
	pip install ansible docker-py 

.PHONY: ansible-awx
ansible-awx:
	. Juniper-awx/bin/activate && \
        git clone https://github.com/ansible/awx.git
	
.PHONY: playbook
playbook:
	@echo $(DOCKERHUB_VERSION)
	@echo $(POSTGRES_DATA_DIR)
	@echo $(PWD)/$(PATH_PROJECTS)
ifneq '$(PATH_PROJECTS)' ''
	sed -i '' '/project_data_dir/s/^#//g' $(PWD)/awx/installer/inventory
	sed -i '' 's|project_data_dir=.*|project_data_dir=$(PWD)/$(PATH_PROJECTS)|g' $(PWD)/awx/installer/inventory
endif
ifneq '$(DOCKERHUB_VERSION)' ''
	sed -i '' 's/dockerhub_version=.*/dockerhub_version=$(DOCKERHUB_VERSION)/g' $(PWD)/awx/installer/inventory
endif
ifneq '$(POSTGRES_DATA_DIR)' ''
	sed -i '' 's|postgres_data_dir=.*|postgres_data_dir=$(POSTGRES_DATA_DIR)|g' $(PWD)/awx/installer/inventory
endif
	. Juniper-awx/bin/activate && \
	ansible-playbook -i $(PWD)/awx/installer/inventory $(PWD)/awx/installer/install.yml


.PHONY: docker
docker:
	docker exec -it awx_task pip install jsnapy jxmlease junos-eznc
	docker exec -it awx_task ansible-galaxy install Juniper.junos,$(ANSIBLE_JUNOS_VERSION) -p  /etc/ansible/roles
	docker exec -it awx_task /bin/bash -c 'sed -i '/roles_path/s/^#//g' /etc/ansible/ansible.cfg'  

.PHONY: docker-stop
docker-stop: ## stop the docker
	docker stop awx_task 
	docker stop awx_web
	docker stop memcached
	docker stop rabbitmq
	docker stop postgres

.PHONY: docker-remove
docker-remove: docker-stop ##clean the docker
	docker rm awx_task
	docker rm awx_web
	docker rm memcached
	docker rm rabbitmq
	docker rm postgres

clean: prequisite  ## clean the project
	docker system prune -f
