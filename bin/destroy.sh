#!/usr/bin/env bash
set -e
set -x

source ./configure.sh

terraform init

terraform plan -destroy

terraform destroy -auto-approve