#!/usr/bin/env bash
set -e
set -x

terraform init

terraform plan

terraform destroy -auto-approve