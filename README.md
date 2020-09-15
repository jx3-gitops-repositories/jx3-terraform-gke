# Google Terraform Quickstart template

Use this template to easily create a new Git Repository for Jenkins X cloud infrastructure needs.

# Getting started

- Create your Infrastructure git repo from this GitHub Template https://github.com/jx3-gitops-repositories/jx3-terraform-gke/generate

- Chose either Google Secret Manager or Vault based cluster GitHub Template
    - Google Secret Manager: https://github.com/jx3-gitops-repositories/jx3-gke-gsm/generate

    - Vault: https://github.com/jx3-gitops-repositories/jx3-gke-terraform-vault/generate

Commit required terraform values from below to your `values.auto.tfvars`, e.g.

```
echo jx_git_url = https://github.com/$owner/$repo_from_cluster_template_above >> values.auto.tfvars
echo jx_bot_username = foo-bot >> values.auto.tfvars
echo jx_bot_token = abc123 >> values.auto.tfvars
echo gcp_project = my-cool-project >> values.auto.tfvars
```
If using Google Secret Manager cluster template from above:
```
echo gsm = true >> values.auto.tfvars
```

```
terraform init
```

```
terraform plan
```

```
terraform apply -auto-approve
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_location | The location (region or zone) in which the cluster master will be created. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region | `string` | `"us-central1-a"` | no |
| cluster\_name | Name of the Kubernetes cluster to create | `string` | `""` | no |
| gcp\_project | The name of the GCP project to use | `string` | n/a | yes |
| gsm | Enables Google Secrets Manager, not available with JX2 | `bool` | `false` | no |
| jx\_bot\_token | Bot token used to interact with the Jenkins X cluster git repository | `string` | n/a | yes |
| jx\_bot\_username | Bot username used to interact with the Jenkins X cluster git repository | `string` | n/a | yes |
| jx\_git\_url | URL for the Jenins X cluster git repository | `string` | n/a | yes |
| lets\_encrypt\_production | Flag to determine wether or not to use the Let's Encrypt production server. | `bool` | `true` | no |
| max\_node\_count | Maximum number of cluster nodes | `number` | `5` | no |
| min\_node\_count | Minimum number of cluster nodes | `number` | `3` | no |
| node\_disk\_size | Node disk size in GB | `string` | `"100"` | no |
| node\_disk\_type | Node disk type, either pd-standard or pd-ssd | `string` | `"pd-standard"` | no |
| node\_machine\_type | Node type for the Kubernetes cluster | `string` | `"n1-standard-2"` | no |
| parent\_domain | The parent domain to be allocated to the cluster | `string` | `""` | no |
| resource\_labels | Set of labels to be applied to the cluster | `map(string)` | `{}` | no |
| tls\_email | Email used by Let's Encrypt. Required for TLS when parent\_domain is specified | `string` | `""` | no |

# Contributing

When adding new variables please regenerate the markdown table 
```sh
terraform-docs markdown table .
```
and replace the Inputs section above

## Formatting

When developing please remember to format codebase before raising a pull request
```sh
terraform fmt -check -diff -recursive
```