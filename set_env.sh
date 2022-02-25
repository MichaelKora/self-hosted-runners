#!/bin/bash

cat > .env <<'EOF'
export OS_REGION_NAME='GRA9'
export OS_AUTH_URL="https://auth.cloud.ovh.net/v3/"
export OS_IDENTITY_API_VERSION="3"
export OS_USER_DOMAIN_NAME="Default"
export OS_PROJECT_DOMAIN_NAME="Default"
EOF
echo export OS_TENANT_ID=$1 >> .env
echo export OS_TENANT_NAME=$2 >> .env
echo export OS_USERNAME=$3 >> .env
echo export OS_PASSWORD=$4 >> .env
source .env
