all:prequisite virtual-env ansible-awx playbook docker ## install juniper-awx

PWD = $(shell pwd)
PATH_PROJECTS = $(PWD)/projects
 
.PHONY: prequisite
prequisite:
	pip install virtualenv
	rm -rf ./awx ./Juniper-awx $(PATH_PROJECTS)        
	mkdir $(PATH_PROJECTS)
	
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
	echo "\nproject_data_dir=$(PATH_PROJECTS)" >> $(PWD)/awx/installer/inventory
	. Juniper-awx/bin/activate && \
	ansible-playbook -i $(PWD)/awx/installer/inventory $(PWD)/awx/installer/install.yml

.PHONY: docker
docker:
	docker exec -it awx_task pip install jsnapy jxmlease junos-eznc
	docker exec -it awx_task ansible-galaxy install Juniper.junos -p  /etc/ansible/roles
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
