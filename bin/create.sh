#!/usr/bin/env bash
set -e
set -x

terraform init

terraform plan

terraform apply -auto-approve -input=false

$(terraform output connect)

$(terraform output follow_install_logs)