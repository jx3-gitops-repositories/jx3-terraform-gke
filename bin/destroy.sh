#!/usr/bin/env bash
set -e
set -x

terraform init

terraform plan

terraform destroy -auto-approve -var.gcp_project=$PROJECT_ID -var.jx_bot_username=$GIT_USERNAME -var.jx_bot_token=$GIT_TOKEN -var.jx_git_url=$GITOPS_REPO