#!/bin/bash

set -eu

until $(curl --output /dev/null -k --silent --head --fail https://$OPSMAN_DOMAIN_OR_IP_ADDRESS/setup); do
    printf '.'
    sleep 5
done

# Hack: bump OM-linux
wget https://github.com/pivotal-cf/om/releases/download/0.51.0/om-linux 
chmod +x ./om-linux

# Set PivNet Token
./om-linux \
  --target https://$OPSMAN_DOMAIN_OR_IP_ADDRESS \
  --skip-ssl-validation \
  -u "$OPS_MGR_USR" \
  -p "$OPS_MGR_PWD" \
  curl --path /api/v0/settings/pivotal_network_settings \
  --request PUT  \
  -d '{ "pivotal_network_settings": { "api_token": '\"$PIVNET_API_TOKEN\"' }}'

if [ -z "$OPS_MGR_SSL_PUB" ]; then
    exit
fi

if [ -z "$OPS_MGR_SSL_PRIV" ]; then
    exit 
fi


./om-linux \
  --target https://$OPSMAN_DOMAIN_OR_IP_ADDRESS \
  --skip-ssl-validation \
  -u "$OPS_MGR_USR" \
  -p "$OPS_MGR_PWD" \
    update-ssl-certificate \
    --certificate-pem "$OPS_MGR_SSL_PUB" \
    --private-key-pem "$OPS_MGR_SSL_PRIV"

sleep 60