#!/bin/bash
file="ip_adresses.txt"

echo "[myrunners]" >> /etc/ansible/hosts
while IFS= read -r line; do
  echo "$line ansible_ssh_user=$1" >> /etc/ansible/hosts
done < "$file"


count=1
while IFS= read -r line; do
  echo "[runner-$count]" >> /etc/ansible/hosts
  echo "$line ansible_ssh_user=$1" >> /etc/ansible/hosts
  count=count+1
done < "$file"

#run the playbook
ansible-playbook playbook.yml
