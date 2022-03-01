#!/bin/bash

#file="ip_adresses.txt"

#echo "[myrunners]" >> ./inventory_file
#while IFS= read -r line; do
#  echo "$line" >> ./inventory_file
#done < "$file"


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
