#!/bin/bash

set -eu
set -x 

ami=$(cat ami/ami)

OPSMAN_ALLOW_SSH=0
OPSMAN_ALLOW_SSH_CIDR_LIST='["0.0.0.0/32"]'
if [[ -n "${OPSMAN_ALLOW_SSH_CIDR_RANGES// }" ]]; then
  OPSMAN_ALLOW_SSH=1
  OPSMAN_ALLOW_SSH_CIDR_LIST='["'${OPSMAN_ALLOW_SSH_CIDR_RANGES//\,/\"\,\"}'"]'
fi

OPSMAN_ALLOW_HTTPS=0
OPSMAN_ALLOW_HTTPS_CIDR_LIST='["0.0.0.0/32"]'
if [[ -n "${OPSMAN_ALLOW_HTTPS_CIDR_RANGES// }" ]]; then
  OPSMAN_ALLOW_HTTPS=1
  OPSMAN_ALLOW_HTTPS_CIDR_LIST='["'${OPSMAN_ALLOW_HTTPS_CIDR_RANGES//\,/\"\,\"}'"]'
fi

terraform init pcf-lab-pipelines/pipelines/install-pks/aws/terraform

terraform plan \
  -state terraform-state/terraform.tfstate \
  -var "opsman_ami=${ami}" \
  -var "access_key=${aws_access_key_id}" \
  -var "secret_key=${aws_secret_access_key}" \
  -var "aws_key_name=${aws_key_name}" \
  -var "region=${aws_region}" \
  -out terraform.tfplan \
  pcf-lab-pipelines/pipelines/install-pks/aws/terraform

terraform apply \
  -state-out terraform-state-output/terraform.tfstate \
  terraform.tfplan