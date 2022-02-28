
#!/bin/bash
#Create mamba environment

wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
./bin/micromamba create --file environment.yml --yes -r $PWD/.micromamba
export PATH=$PWD/.micromamba/envs/default/bin:$PATH


#          sudo apt update
#          sudo apt install software-properties-common
#          sudo add-apt-repository --yes --update ppa:ansible/ansible
#          sudo apt install ansible
#          sudo apt install python-openstackclient
