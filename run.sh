#!/bin/bash

file="ip_adresses.txt"
# store list of vm in a text file
openstack server list > server_list.txt
cat server_list.txt

python setup.py


# copy the key of the runner in the vm in order to be able to reach them using ssh and therefore ansible
echo "***copying runner ssh key to new created instances..."
while IFS= read -r line; do
    ssh-copy-id -i id_rsa.pub ubuntu@"$line"
done < "$file"
echo "***ssh key copied!"

#show ansibe terraform inventory
echo "***ansible commands ... "
ansible-inventory --list

#run the playbook
ansible-playbook playbook.yml
