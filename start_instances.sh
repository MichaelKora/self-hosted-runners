#!/bin/bash

#Create mamba environment
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba create --file environment.yml --yes -r $PWD/.micromamba
export PATH=$PWD/.micromamba/envs/default/bin:$PATH

#create ssh key
ssh-keygen -q -N "" -f id_rsa

cd tf/openstack
terraform init
terraform plan
terraform apply -auto-approve
cd ../..
# store list of vm in a text file
openstack server list > server_list.txt




#grep "*github-runner*" test.txt | awk '$3 == "ACTIVE" {print $2 } " ansible_ssh_user=michaelkora"' >> ./instances.txt

#write addresses in the host files for ansible
#echo "[servers]" >> /etc/ansible/hosts
