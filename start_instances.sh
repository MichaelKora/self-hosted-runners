#!/bin/bash

#create ssh key
ssh-keygen -q -N "" -f id_rsa

cd tf/openstack
terraform init
terraform plan
terraform apply -auto-approve
terraform state pull >> result.txt
cat result.txt
cd ../..

sleep 60
