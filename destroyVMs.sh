#!/bin/bash

#Create mamba environment
#wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
#./bin/micromamba create --file environment.yml --yes -r $PWD/.micromamba
#export PATH=$PWD/.micromamba/envs/default/bin:$PATH
echo "delete scripts"
#openstack server list > server_list.txt

#python delete.py

#echo "after delete"
#openstack server list

#openstack server delete github-runner-0
#ssh-keygen -q -N "" -f id_rsa

cd tf/openStack
#terraform init
terraform apply -destroy -auto-approve
