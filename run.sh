#!/bin/bash

file="ip_adresses.txt"

echo "[myrunners]" >> ./inventory_file
while IFS= read -r line; do
  echo "$line ansible_ssh_user=$1" >> ./inventory_file
done < "$file"


declare -i count=1
while IFS= read -r line; do
  echo "[runner-$count]" >> ./inventory_file
  echo "$line ansible_ssh_user=$1" >> ./inventory_file
  count=$count+1
done < "$file"

cat ./inventory_file
#run the playbook
ansible-playbook -i inventory_file playbook.yml
