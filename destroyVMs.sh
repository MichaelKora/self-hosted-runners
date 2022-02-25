#!/bin/bash

#Create mamba environment
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba create --file environment.yml --yes -r $PWD/.micromamba
export PATH=$PWD/.micromamba/envs/default/bin:$PATH


cd tf/openstack
terraform init
terraform destroy
