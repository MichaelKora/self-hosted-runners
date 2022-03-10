#!/bin/bash

echo "***delete scripts..."
##     manual deletion
#openstack server list > server_list.txt
#python delete.py
#echo "after delete"
#openstack server list

#openstack server delete github-runner-0
#ssh-keygen -q -N "" -f id_rsa
cd tf/openstack

echo "***************** ls -al tf/openstack****************************"
ls -al
echo "++++++++++++++++++++++++++++++++++++++++++++++++"
cat terraform.tfstate

terraform apply -destroy -auto-approve
