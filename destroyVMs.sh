#!/bin/bash


cd tf/openstack
echo "**** current tfstate ****"
cat terraform.tfstate
echo "**** terraform apply -destroy -auto-approve ****"
terraform apply -destroy -auto-approve
