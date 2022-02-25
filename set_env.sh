cat > .env <<'EOF'
export OS_REGION_NAME='GRA9'
export OS_AUTH_URL="https://auth.cloud.ovh.net/v3/"
export OS_IDENTITY_API_VERSION="3"
export OS_USER_DOMAIN_NAME="Default"
export OS_PROJECT_DOMAIN_NAME="Default"
export TF_VAR_auth_url=$OS_AUTH_URL
EOF

echo export OS_TENANT_ID=$1 >> .env
echo OS_TENANT_NAME=$2 >> .env
echo export OS_USERNAME=$3 >> .env
echo export OS_PASSWORD=$4 >> .env
echo export TF_VAR_keypair_name= $5 >> .env

echo export TF_VAR_region="DE1" >> .env
echo export TF_VAR_user_name=$OS_USERNAME >> .env
echo export TF_VAR_password=$OS_PASSWORD >> .env
echo export TF_VAR_user_domain_name=$OS_USER_DOMAIN_NAME >> .env
echo export TF_VAR_tenant_name=$OS_TENANT_NAME >> .env
echo export TF_VAR_tenant_id=$OS_TENANT_ID >> .env
echo export TF_VAR_ansible_user=$6 >> .env

source .env
export TF_VAR_region="DE1"
export TF_VAR_user_name=$OS_USERNAME
export TF_VAR_password=$OS_PASSWORD
export TF_VAR_user_domain_name=$OS_USER_DOMAIN_NAME
export TF_VAR_tenant_name=$OS_TENANT_NAME
export TF_VAR_tenant_id=$OS_TENANT_ID
export TF_VAR_ansible_user=$6