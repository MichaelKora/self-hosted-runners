# self-hosted-runners
This repository contains information on deploying self-hosted runners. The following technologies are covered/used in this project: Ansible (for configuration), Terraform and OpenStack for provisioning, Pipelines (GitHub Actions) and shell scripts for automation, and Python for the implementation of a Terraform plugin.

I'm using Terraform and Openstack to create instances at **runtime**, and then I'm configuring those instances to become runners with ansible. After that, I assign them jobs from the Pipeline using labels. After all jobs have been completed, I use 'terraform' to delete all resources that have been created.


- Set up
  > Make sure you store your openstack credentials(OS_TENANT_ID,OS_TENANT_NAME,OS_USERNAME,OS_PASSWORD) in github secrets so they can be accessed in the `github-actions` using **${{ secrets.OS_TENANT_ID }}**, **${{ secrets.OS_TENANT_NAME }}**, **${{ secrets.OS_USERNAME }}**, **${{ secrets.OS_PASSWORD }}**.
  > - Upload the keys using the gh command.
    > - E.g.: ` gh secret set OS_TENANT_ID --body "$OS_TENANT_ID" `
  
      
- create instances.
  >  In this project i have three jobs to run on three different machines. In order to do so, machines are created from a github action (from a standard github runner) using terraform - openstack.
The image names and the flavour names can be set in the file **tf/openstack/instance.tf**. 
    > - If you are creating other machines than `ubuntu` machines make sure to change the value of the variable `TF_VAR_ANSIBLE_USER` in the file **.github/workflows/main.yml**.
      > - You should also take a look at the documentation on how to create a runner and copy the right command for the instances you are creating (if they are not ubuntu instances)

- configure instances
  > In order for you to use the instances as runners there are some command to be run. You need other commands if you are not using ubuntu machines (update the command in the `ansible-playbook`). Please take a look at the [documentation](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners) and also this [documentation](https://docs.github.com/en/actions/hosting-your-own-runners/configuring-the-self-hosted-runner-application-as-a-service).
  > In order to the instances to connect to your repository, github creates some tokens for you. Those token are valid just for 60min. So make sure you use a new token each time you run the deployment. To get a new token just refresh the page. 
  > See the token and commands here `repository->settings-> Actions->Runners->New sel-hosted runner`.

- Change the amount of server
  > Note that the number of server can be increased or decreased by changing the value of the variable `server_count` in the file **tf/openstack/instance.tf**. 
    > - Do not forgot to change the values of `image_names` and `flavor_names` as well

- Access  created instances
  > the created instances are reachable from the runner using ansible (and therefore ssh) in order to also ssh in the created instances from your local machine. You have to make sure that the machine has his ssh key stored in your github account. If that's done then you can copy the ip addresse of the machine you want to access in the log(of the github actions). 
    > - with the ip address and the ansible user, access the ssh command to access the instance: `ssh ubuntu@extern_ip`. `ubuntu` here is the ansible user.
    > - P.S.: once all jobs are terminated, the created instances and keys are deleted. So you might not be able to access the instances once the jobs terminated. To avoid this you can right a `sleep` command in one of the self hosted runners jobs so that you have more time to login. 

- Important
  > github recommand to use sel-hosted runners in private repository. 
