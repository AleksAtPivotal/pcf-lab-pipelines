#!/bin/bash

set -eu

until $(curl --output /dev/null -k --silent --head --fail https://$OPSMAN_DOMAIN_OR_IP_ADDRESS/setup); do
    printf '.'
    sleep 5
done

if [ -z "$OPS_MGR_SSL_PUB" ]; then
    exit
fi

if [ -z "$OPS_MGR_SSL_PRIV" ]; then
    exit 
fi

# Hack: bump OM-linux
wget https://github.com/pivotal-cf/om/releases/download/0.51.0/om-linux 
chmod +x ./om-linux

./om-linux \
  --target https://$OPSMAN_DOMAIN_OR_IP_ADDRESS \
  --skip-ssl-validation \
  -u "$OPS_MGR_USR" \
  -p "$OPS_MGR_PWD" \
    update-ssl-certificate \
    --certificate-pem "$OPS_MGR_SSL_PUB" \
    --private-key-pem "$OPS_MGR_SSL_PRIV"

sleep 60