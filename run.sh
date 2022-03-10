#!/bin/bash

openstack server list 

#show ansibe terraform inventory
echo "***ansible commands ... "
ansible-inventory --list

#run the playbook
ansible-playbook playbook.yml
