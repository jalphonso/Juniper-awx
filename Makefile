all:prequisite virtual-env ansible-awx playbook docker ## install juniper-awx

PWD = $(shell pwd)
PATH_PROJECTS = $(PWD)/projects
ANSIBLE_CFG_PATH = /root/.ansible/roles
 
.PHONY: prequisite
prequisite:
	rm -rf ./awx ./juniper-awx $(PATH_PROJECTS)        
	mkdir $(PATH_PROJECTS)
	
.PHONY: virtual-env
virtual-env:
	virtualenv juniper-awx --no-site-packages
	. juniper-awx/bin/activate && \
	pip install ansible docker-py 

.PHONY: ansible-awx
ansible-awx:
	. juniper-awx/bin/activate && \
        git clone https://github.com/ansible/awx.git
	
.PHONY: playbook
playbook:
	echo "\nproject_data_dir=$(PATH_PROJECTS)" >> $(PWD)/awx/installer/inventory
	. juniper-awx/bin/activate && \
	ansible-playbook -i $(PWD)/awx/installer/inventory $(PWD)/awx/installer/install.yml

.PHONY: docker
docker:
	docker exec -it awx_task pip install jsnapy jxmlease junos-eznc
	docker exec -it awx_task ansible-galaxy install Juniper.junos
	docker exec -it awx_task /bin/bash -c 'sed -i '/roles_path/s/^#//g' /etc/ansible/ansible.cfg'  

docker-stop: ## stop the docker
	docker stop awx_task 
	docker stop awx_web
	docker stop memcached
	docker stop rabbitmq
	docker stop postgres

docker-clean: ##clean the docker
	docker rm awx_task
	docker rm awx_web
	docker rm memcached
	docker rm rabbitmq
	docker rm postgres

clean: prequisite  ## clean the project
	docker system prune -f
