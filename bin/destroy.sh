#!/usr/bin/env bash
set -e
set -x

source `dirname $0`/configure.sh

terraform init

echo "lets connect to the cluster that we are about to destroy so that any helm charts are removed in the right kubernetes cluster..."

$(terraform output -raw connect)

terraform plan -destroy

terraform destroy -auto-approve
