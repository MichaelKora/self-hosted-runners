#!/bin/bash


#create ssh key
ssh-keygen -q -N "" -f id_rsa

cd tf/openStack
terraform init
terraform plan
terraform apply -auto-approve
terraform state pull >> result.txt
cat result.txt

cd ../..
# store list of vm in a text file
openstack server list > server_list.txt
cat server_list.txt


