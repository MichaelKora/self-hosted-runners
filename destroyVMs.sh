#!/bin/bash

echo "***delete scripts..."

##     manual deletion
#openstack server list > server_list.txt
#python delete.py

cd tf/openstack

echo "***************** ls -al tf/openstack****************************"
ls -al
echo "++++++++++++++++++++++++++++++++++++++++++++++++"
cat terraform.tfstate

terraform apply -destroy -auto-approve
