#!/bin/bash
export TF_VAR_keypair_name="MichaelKora"

export TF_VAR_ansible_user="ubuntu"
export TF_VAR_region=$OS_REGION_NAME
export TF_VAR_auth_url=$OS_AUTH_URL
export TF_VAR_user_name=$OS_USERNAME
export TF_VAR_password=$OS_PASSWORD
export TF_VAR_user_domain_name=$OS_USER_DOMAIN_NAME
export TF_VAR_tenant_name=$OS_TENANT_NAME
export TF_VAR_tenant_id=$OS_TENANT_ID


# Set image + flavour
export TF_VAR_ansible_user="debian"
export TF_VAR_image_name="Debian 11"
export TF_VAR_flavor_name="d2-8"

# Set Instance Name

export TF_VAR_instance_name="myfirstinstance"

