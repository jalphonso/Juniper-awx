## About

Juniper-awx provides a web-based user interface and task engine built on top of [Ansible](https://github.com/ansible/ansible.git) which helps to perform specific
operational and configuration tasks on devices running Junos OS using [ansible-junos-stdlib](https://github.com/Juniper/ansible-junos-stdlib.git).

## Requirements

 [Docker](https://www.docker.com)
 pip module

## Installation

Clone repo and run make inside Juniper-awx folder

```
$ https://github.com/dineshbaburam91/Juniper-awx.git
$ make or make all
```

This will create the virtualenv and install ansible, docker-py, clone and install awx inside the python virtualenv.
Also, install jsnapy, jxmlease, junos-eznc and juniper ansible inside aws-task docker.

# Example make

```
$ make all
pip install virtualenv
Requirement already satisfied: virtualenv in /Library/Python/2.7/site-packages
rm -rf ./awx ./Juniper-awx /tmp/Juniper-awx/projects
mkdir /tmp/Juniper-awx/projects
virtualenv Juniper-awx --no-site-packages
New python executable in /private/tmp/Juniper-awx/Juniper-awx/bin/python
Installing setuptools, pip, wheel...done.
. Juniper-awx/bin/activate && \
	pip install ansible docker-py
Collecting ansible
Collecting docker-py
  Using cached docker_py-1.10.6-py2.py3-none-any.whl
Collecting PyYAML (from ansible)
Collecting cryptography (from ansible)
  Using cached cryptography-2.1.4-cp27-cp27m-macosx_10_6_intel.whl
Collecting jinja2 (from ansible)
  Using cached Jinja2-2.10-py2.py3-none-any.whl
Requirement already satisfied: setuptools in ./Juniper-awx/lib/python2.7/site-packages (from ansible)
Collecting paramiko (from ansible)
  Using cached paramiko-2.4.0-py2.py3-none-any.whl
Collecting requests!=2.11.0,>=2.5.2 (from docker-py)
  Using cached requests-2.18.4-py2.py3-none-any.whl
Collecting backports.ssl-match-hostname>=3.5; python_version < "3.5" (from docker-py)
Collecting ipaddress>=1.0.16; python_version < "3.3" (from docker-py)
Collecting docker-pycreds>=0.2.1 (from docker-py)
  Using cached docker_pycreds-0.2.1-py2.py3-none-any.whl
Collecting websocket-client>=0.32.0 (from docker-py)
  Using cached websocket_client-0.46.0-py2.py3-none-any.whl
Collecting six>=1.4.0 (from docker-py)
  Using cached six-1.11.0-py2.py3-none-any.whl
Collecting idna>=2.1 (from cryptography->ansible)
  Using cached idna-2.6-py2.py3-none-any.whl
Collecting cffi>=1.7; platform_python_implementation != "PyPy" (from cryptography->ansible)
  Using cached cffi-1.11.4-cp27-cp27m-macosx_10_6_intel.whl
Collecting enum34; python_version < "3" (from cryptography->ansible)
  Using cached enum34-1.1.6-py2-none-any.whl
Collecting asn1crypto>=0.21.0 (from cryptography->ansible)
  Using cached asn1crypto-0.24.0-py2.py3-none-any.whl
Collecting MarkupSafe>=0.23 (from jinja2->ansible)
Collecting pynacl>=1.0.1 (from paramiko->ansible)
  Using cached PyNaCl-1.2.1-cp27-cp27m-macosx_10_6_intel.whl
Collecting bcrypt>=3.1.3 (from paramiko->ansible)
  Using cached bcrypt-3.1.4-cp27-cp27m-macosx_10_6_intel.whl
Collecting pyasn1>=0.1.7 (from paramiko->ansible)
  Using cached pyasn1-0.4.2-py2.py3-none-any.whl
Collecting urllib3<1.23,>=1.21.1 (from requests!=2.11.0,>=2.5.2->docker-py)
  Using cached urllib3-1.22-py2.py3-none-any.whl
Collecting chardet<3.1.0,>=3.0.2 (from requests!=2.11.0,>=2.5.2->docker-py)
  Using cached chardet-3.0.4-py2.py3-none-any.whl
Collecting certifi>=2017.4.17 (from requests!=2.11.0,>=2.5.2->docker-py)
  Using cached certifi-2018.1.18-py2.py3-none-any.whl
Collecting pycparser (from cffi>=1.7; platform_python_implementation != "PyPy"->cryptography->ansible)
Installing collected packages: PyYAML, idna, pycparser, cffi, enum34, six, asn1crypto, ipaddress, cryptography, MarkupSafe, jinja2, pynacl, bcrypt, pyasn1, paramiko, ansible, urllib3, chardet, certifi, requests, backports.ssl-match-hostname, docker-pycreds, websocket-client, docker-py
Successfully installed MarkupSafe-1.0 PyYAML-3.12 ansible-2.4.3.0 asn1crypto-0.24.0 backports.ssl-match-hostname-3.5.0.1 bcrypt-3.1.4 certifi-2018.1.18 cffi-1.11.4 chardet-3.0.4 cryptography-2.1.4 docker-py-1.10.6 docker-pycreds-0.2.1 enum34-1.1.6 idna-2.6 ipaddress-1.0.19 jinja2-2.10 paramiko-2.4.0 pyasn1-0.4.2 pycparser-2.18 pynacl-1.2.1 requests-2.18.4 six-1.11.0 urllib3-1.22 websocket-client-0.46.0
. Juniper-awx/bin/activate && \
        git clone https://github.com/ansible/awx.git
Cloning into 'awx'...
remote: Counting objects: 160183, done.
remote: Compressing objects: 100% (59/59), done.
Receiving objects: 100% (160183/160183), 191.54 MiB | 1.32 MiB/s, done.
remote: Total 160183 (delta 35), reused 21 (delta 8), pack-reused 160116
Resolving deltas: 100% (123398/123398), done.
Checking out files: 100% (2279/2279), done.
echo "\nproject_data_dir=/tmp/Juniper-awx/projects" >> /tmp/Juniper-awx/awx/installer/inventory
. Juniper-awx/bin/activate && \
	ansible-playbook -i /tmp/Juniper-awx/awx/installer/inventory /tmp/Juniper-awx/awx/installer/install.yml

PLAY [Build and deploy AWX] ******************************************************************************************************

TASK [check_vars : include_tasks] ************************************************************************************************
skipping: [localhost]

TASK [check_vars : include_tasks] ************************************************************************************************
included: /private/tmp/Juniper-awx/awx/installer/check_vars/tasks/check_docker.yml for localhost

TASK [check_vars : postgres_data_dir should be defined] **************************************************************************
ok: [localhost] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [check_vars : host_port should be defined] **********************************************************************************
ok: [localhost] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [image_build : Get Version from checkout if not provided] *******************************************************************
skipping: [localhost]

TASK [image_build : Set global version if not provided] **************************************************************************
skipping: [localhost]

TASK [image_build : Verify awx-logos directory exists for official install] ******************************************************
skipping: [localhost]

TASK [image_build : Copy logos for inclusion in sdist] ***************************************************************************
skipping: [localhost]

TASK [image_build : Set sdist file name] *****************************************************************************************
skipping: [localhost]

TASK [image_build : AWX Distribution] ********************************************************************************************
skipping: [localhost]

TASK [image_build : Stat distribution file] **************************************************************************************
skipping: [localhost]

TASK [image_build : Clean distribution] ******************************************************************************************
skipping: [localhost]

TASK [image_build : Build sdist builder image] ***********************************************************************************
skipping: [localhost]

TASK [image_build : Build AWX distribution using container] **********************************************************************
skipping: [localhost]

TASK [image_build : Build AWX distribution locally] ******************************************************************************
skipping: [localhost]

TASK [image_build : Set docker build base path] **********************************************************************************
skipping: [localhost]

TASK [image_build : Set awx_web image name] **************************************************************************************
skipping: [localhost]

TASK [image_build : Set awx_task image name] *************************************************************************************
skipping: [localhost]

TASK [image_build : Ensure directory exists] *************************************************************************************
skipping: [localhost]

TASK [image_build : Stage sdist] *************************************************************************************************
skipping: [localhost]

TASK [image_build : Template web Dockerfile] *************************************************************************************
skipping: [localhost]

TASK [image_build : Template task Dockerfile] ************************************************************************************
skipping: [localhost]

TASK [image_build : Stage launch_awx] ********************************************************************************************
skipping: [localhost]

TASK [image_build : Stage launch_awx_task] ***************************************************************************************
skipping: [localhost]

TASK [image_build : Stage nginx.conf] ********************************************************************************************
skipping: [localhost]

TASK [image_build : Stage supervisor.conf] ***************************************************************************************
skipping: [localhost]

TASK [image_build : Stage supervisor_task.conf] **********************************************************************************
skipping: [localhost]

TASK [image_build : Stage settings.py] *******************************************************************************************
skipping: [localhost]

TASK [image_build : Stage requirements] ******************************************************************************************
skipping: [localhost]

TASK [image_build : Stage config watcher] ****************************************************************************************
skipping: [localhost]

TASK [image_build : Stage Makefile] **********************************************************************************************
skipping: [localhost]

TASK [image_build : Stage ansible repo] ******************************************************************************************
skipping: [localhost]

TASK [image_build : Stage ansible repo key] **************************************************************************************
skipping: [localhost]

TASK [image_build : Build base web image] ****************************************************************************************
skipping: [localhost]

TASK [image_build : Build base task image] ***************************************************************************************
skipping: [localhost]

TASK [image_build : Clean docker base directory] *********************************************************************************
skipping: [localhost]

TASK [openshift : Authenticate with OpenShift] ***********************************************************************************
skipping: [localhost]

TASK [openshift : Get Project Detail] ********************************************************************************************
skipping: [localhost]

TASK [openshift : Get Postgres Service Detail] ***********************************************************************************
skipping: [localhost]

TASK [openshift : Create AWX Openshift Project] **********************************************************************************
skipping: [localhost]

TASK [openshift : Mark Openshift User as Admin] **********************************************************************************
skipping: [localhost]

TASK [openshift : Set docker registry password] **********************************************************************************
skipping: [localhost]

TASK [openshift : Set docker registry password] **********************************************************************************
skipping: [localhost]

TASK [openshift : Authenticate with Docker registry] *****************************************************************************
skipping: [localhost]

TASK [openshift : Wait for Openshift] ********************************************************************************************
skipping: [localhost]

TASK [openshift : Tag and push web image to registry] ****************************************************************************
skipping: [localhost]

TASK [openshift : Wait for the registry to settle] *******************************************************************************
skipping: [localhost]

TASK [openshift : Tag and push task image to registry] ***************************************************************************
skipping: [localhost]

TASK [openshift : Enable image stream lookups for awx images] ********************************************************************
skipping: [localhost]

TASK [openshift : Set full web image path] ***************************************************************************************
skipping: [localhost]

TASK [openshift : Set full task image path] **************************************************************************************
skipping: [localhost]

TASK [openshift : Set DockerHub Image Paths] *************************************************************************************
skipping: [localhost]

TASK [openshift : Deploy and Activate Postgres] **********************************************************************************
skipping: [localhost]

TASK [openshift : Wait for Postgres to activate] *********************************************************************************
skipping: [localhost]

TASK [openshift : Set openshift base path] ***************************************************************************************
skipping: [localhost]

TASK [openshift : Ensure directory exists] ***************************************************************************************
skipping: [localhost]

TASK [openshift : Template Openshift AWX Config] *********************************************************************************
skipping: [localhost]

TASK [openshift : Template Openshift AWX Deployment] *****************************************************************************
skipping: [localhost]

TASK [openshift : Template Openshift AWX etcd2] **********************************************************************************
skipping: [localhost]

TASK [openshift : Apply etcd deployment] *****************************************************************************************
skipping: [localhost]

TASK [openshift : Apply Configmap] ***********************************************************************************************
skipping: [localhost]

TASK [openshift : Apply Deployment] **********************************************************************************************
skipping: [localhost]

TASK [kubernetes : Set the Kubernetes Context] ***********************************************************************************
skipping: [localhost]

TASK [kubernetes : Get Namespace Detail] *****************************************************************************************
skipping: [localhost]

TASK [kubernetes : Get Postgres Service Detail] **********************************************************************************
skipping: [localhost]

TASK [kubernetes : Create AWX Kubernetes Project] ********************************************************************************
skipping: [localhost]

TASK [kubernetes : Authenticate with Docker registry] ****************************************************************************
skipping: [localhost]

TASK [kubernetes : Wait for Openshift] *******************************************************************************************
skipping: [localhost]

TASK [kubernetes : Tag and push web image to registry] ***************************************************************************
skipping: [localhost]

TASK [kubernetes : Wait for the registry to settle] ******************************************************************************
skipping: [localhost]

TASK [kubernetes : Tag and push task image to registry] **************************************************************************
skipping: [localhost]

TASK [kubernetes : Set full web image path] **************************************************************************************
skipping: [localhost]

TASK [kubernetes : Set full task image path] *************************************************************************************
skipping: [localhost]

TASK [kubernetes : Set DockerHub Image Paths] ************************************************************************************
skipping: [localhost]

TASK [kubernetes : Deploy and Activate Postgres] *********************************************************************************
skipping: [localhost]

TASK [kubernetes : Set postgresql hostname to helm package service] **************************************************************
skipping: [localhost]

TASK [kubernetes : Wait for Postgres to activate] ********************************************************************************
skipping: [localhost]

TASK [kubernetes : Set kubernetes base path] *************************************************************************************
skipping: [localhost]

TASK [kubernetes : Ensure directory exists] **************************************************************************************
skipping: [localhost]

TASK [kubernetes : Template Kubernetes AWX etcd2] ********************************************************************************
skipping: [localhost]

TASK [kubernetes : Template Kubernetes AWX Config] *******************************************************************************
skipping: [localhost]

TASK [kubernetes : Template Kubernetes AWX Deployment] ***************************************************************************
skipping: [localhost]

TASK [kubernetes : Apply etcd deployment] ****************************************************************************************
skipping: [localhost]

TASK [kubernetes : Apply Configmap] **********************************************************************************************
skipping: [localhost]

TASK [kubernetes : Apply Deployment] *********************************************************************************************
skipping: [localhost]

TASK [local_docker : Export Docker web image if it isnt local and there isnt a registry defined] *********************************
skipping: [localhost]

TASK [local_docker : Export Docker task image if it isnt local and there isnt a registry defined] ********************************
skipping: [localhost]

TASK [local_docker : Authenticate with Docker registry if registry password given] ***********************************************
skipping: [localhost]

TASK [local_docker : Set docker base path] ***************************************************************************************
skipping: [localhost]

TASK [local_docker : Ensure directory exists] ************************************************************************************
skipping: [localhost]

TASK [local_docker : Copy web image to docker execution] *************************************************************************
skipping: [localhost]

TASK [local_docker : Copy task image to docker execution] ************************************************************************
skipping: [localhost]

TASK [local_docker : Load web image] *********************************************************************************************
skipping: [localhost]

TASK [local_docker : Load task image] ********************************************************************************************
skipping: [localhost]

TASK [local_docker : include_role] ***********************************************************************************************
skipping: [localhost]

TASK [local_docker : Set full image path for local install] **********************************************************************
skipping: [localhost]

TASK [local_docker : Set DockerHub Image Paths] **********************************************************************************
ok: [localhost]

TASK [local_docker : Activate postgres container] ********************************************************************************
changed: [localhost]

TASK [local_docker : Activate rabbitmq container] ********************************************************************************
changed: [localhost]

TASK [local_docker : Activate memcached container] *******************************************************************************
changed: [localhost]

TASK [local_docker : Wait for postgres and rabbitmq to activate] *****************************************************************
Pausing for 15 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
ok: [localhost]

TASK [local_docker : Set properties without postgres for awx_web] ****************************************************************
skipping: [localhost]

TASK [local_docker : Set properties with postgres for awx_web] *******************************************************************
ok: [localhost]

TASK [local_docker : Set properties without postgres for awx_task] ***************************************************************
skipping: [localhost]

TASK [local_docker : Set properties with postgres for awx_task] ******************************************************************
ok: [localhost]

TASK [local_docker : Activate AWX Web Container] *********************************************************************************
changed: [localhost]

TASK [local_docker : Activate AWX Task Container] ********************************************************************************
changed: [localhost]

TASK [local_docker : Create /var/lib/awx directory] ******************************************************************************
skipping: [localhost]

TASK [local_docker : Create docker-compose.yml file] *****************************************************************************
skipping: [localhost]

TASK [local_docker : Start the containers] ***************************************************************************************
skipping: [localhost]

PLAY RECAP ***********************************************************************************************************************
localhost                  : ok=12   changed=5    unreachable=0    failed=0

docker exec -it awx_task pip install jsnapy jxmlease junos-eznc
Collecting jsnapy
  Downloading jsnapy-1.3.1.tar.gz (50kB)
    100% |################################| 51kB 68kB/s
Collecting jxmlease
  Downloading jxmlease-1.0.1-py2.py3-none-any.whl
Collecting junos-eznc
  Downloading junos_eznc-2.1.7-py2.py3-none-any.whl (150kB)
    100% |################################| 153kB 172kB/s
Collecting colorama (from jsnapy)
  Downloading colorama-0.3.9-py2.py3-none-any.whl
Collecting configparser (from jsnapy)
  Downloading configparser-3.5.0.tar.gz
Collecting pyparsing (from jsnapy)
  Downloading pyparsing-2.2.0-py2.py3-none-any.whl (56kB)
    100% |################################| 61kB 188kB/s
Collecting icdiff (from jsnapy)
  Downloading icdiff-1.9.1.tar.gz
Collecting future (from jsnapy)
  Downloading future-0.16.0.tar.gz (824kB)
    100% |################################| 829kB 100kB/s
Collecting ncclient>=0.5.3 (from junos-eznc)
  Downloading ncclient-0.5.3.tar.gz (63kB)
    100% |################################| 71kB 126kB/s
Requirement already satisfied (use --upgrade to upgrade): paramiko>=1.15.2 in /usr/lib/python2.7/site-packages (from junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): six in /usr/lib/python2.7/site-packages (from junos-eznc)
Collecting scp>=0.7.0 (from junos-eznc)
  Downloading scp-0.10.2-py2.py3-none-any.whl
Requirement already satisfied (use --upgrade to upgrade): jinja2>=2.7.1 in /usr/lib/python2.7/site-packages (from junos-eznc)
Collecting lxml>=3.2.4 (from junos-eznc)
  Downloading lxml-4.1.1-cp27-cp27mu-manylinux1_x86_64.whl (5.6MB)
    100% |################################| 5.6MB 65kB/s
Collecting pyserial (from junos-eznc)
  Downloading pyserial-3.4-py2.py3-none-any.whl (193kB)
    100% |################################| 194kB 131kB/s
Requirement already satisfied (use --upgrade to upgrade): PyYAML>=3.10 in /usr/lib64/python2.7/site-packages (from junos-eznc)
Collecting netaddr (from junos-eznc)
  Downloading netaddr-0.7.19-py2.py3-none-any.whl (1.6MB)
    100% |################################| 1.6MB 110kB/s
Requirement already satisfied (use --upgrade to upgrade): setuptools>0.6 in /usr/lib/python2.7/site-packages (from ncclient>=0.5.3->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): cryptography>=1.1 in /usr/lib64/python2.7/site-packages (from paramiko>=1.15.2->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): pyasn1>=0.1.7 in /usr/lib/python2.7/site-packages (from paramiko>=1.15.2->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): MarkupSafe in /usr/lib64/python2.7/site-packages (from jinja2>=2.7.1->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): idna>=2.0 in /usr/lib/python2.7/site-packages (from cryptography>=1.1->paramiko>=1.15.2->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): enum34 in /usr/lib/python2.7/site-packages (from cryptography>=1.1->paramiko>=1.15.2->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): ipaddress in /usr/lib/python2.7/site-packages (from cryptography>=1.1->paramiko>=1.15.2->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): cffi>=1.4.1 in /usr/lib64/python2.7/site-packages (from cryptography>=1.1->paramiko>=1.15.2->junos-eznc)
Requirement already satisfied (use --upgrade to upgrade): pycparser in /usr/lib/python2.7/site-packages (from cffi>=1.4.1->cryptography>=1.1->paramiko>=1.15.2->junos-eznc)
Installing collected packages: lxml, ncclient, scp, pyserial, netaddr, junos-eznc, colorama, configparser, pyparsing, icdiff, future, jsnapy, jxmlease
  Running setup.py install for ncclient ... done
  Running setup.py install for configparser ... done
  Running setup.py install for icdiff ... done
  Running setup.py install for future ... done
  Running setup.py install for jsnapy ... done
Successfully installed colorama-0.3.9 configparser-3.5.0 future-0.16.0 icdiff-1.9.1 jsnapy-1.3.1 junos-eznc-2.1.7 jxmlease-1.0.1 lxml-4.1.1 ncclient-0.5.3 netaddr-0.7.19 pyparsing-2.2.0 pyserial-3.4 scp-0.10.2
You are using pip version 8.1.2, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
docker exec -it awx_task ansible-galaxy install Juniper.junos -p  /etc/ansible/roles
- downloading role 'junos', owned by Juniper
- downloading role from https://github.com/Juniper/ansible-junos-stdlib/archive/2.0.1.tar.gz
- extracting Juniper.junos to /etc/ansible/roles/Juniper.junos
- Juniper.junos (2.0.1) was installed successfully
docker exec -it awx_task /bin/bash -c 'sed -i '/roles_path/s/^#//g' /etc/ansible/ansible.cfg'

```

```
## make docker-remove
 This command will stop and remove the docker container

$ make docker-remove
docker stop awx_task
awx_task
docker stop awx_web
awx_web
docker stop memcached
memcached
docker stop rabbitmq
rabbitmq
docker stop postgres
postgres
docker rm awx_task
awx_task
docker rm awx_web
awx_web
docker rm memcached
memcached
docker rm rabbitmq
rabbitmq
docker rm postgres
postgres

```











