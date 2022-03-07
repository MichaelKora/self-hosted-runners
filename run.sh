#!/bin/bash

file="ip_adresses.txt"
# store list of vm in a text file
openstack server list > server_list.txt
cat server_list.txt

python setup.py



while IFS= read -r line; do
    ssh-copy-id -i id_rsa.pub ubuntu@$line
done < "$file"


#declare -i count=1
#while IFS= read -r line; do
#  echo "[runner-$count]" >> ./inventory_file
#  echo "$line" >> ./inventory_file
#  count=$count+1
#done < "$file"

#cat ./inventory_file


echo "ansible commands ... "

#show ansibe terraform inventory
ansible-inventory --list

#run the playbook
ansible-playbook playbook.yml
