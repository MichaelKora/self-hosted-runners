#!/bin/bash
echo "ruuuuuun"
ls -al /etc/
file="ip_adresses.txt"
sudo touch /etc/ansible/hosts
chmod 777 /etc/ansible/hosts
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
