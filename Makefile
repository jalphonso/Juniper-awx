all:prequisite virtual-env ansible-awx docker 

.PHONY: prequisite
prequisite:
	rm -rf ./awx
	rm -rf ./juniper-awx
	
.PHONY: virtual-env
virtual-env:
	virtualenv juniper-awx --no-site-packages
	. juniper-awx/bin/activate && \
	pip install ansible docker-py 

.PHONY: ansible-awx
ansible-awx:
	. juniper-awx/bin/activate && \
        git clone https://github.com/ansible/awx.git && \
        ansible-playbook -i ./awx/installer/inventory ./awx/installer/install.yml
	
.PHONY: docker
docker:
	docker exec -it awx_task pip install jsnapy jxmlease junos-eznc
	docker exec -it awx_task ansible-galaxy install Juniper.junos

docker-stop: ## stop the docker
	docker stop awx_task 
	docker stop awx_web
	docker stop memcached
	docker stop rabbitmq
	docker stop postgres

clean: prequisite  ## clean the project
	docker system prune -f

