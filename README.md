# Google Terraform Quickstart template

Use this template to easily create a new Git Repository for managing Jenkins X cloud infrastructure needs.

We recommend using Terraform to manange the infrastructure needed to run Jenkins X.  There are a number of cloud resources which may need to be created such as:

- Kubernetes cluster
- Storage buckets for long term storage of logs
- IAM Bindings to manage permissions for applications using cloud resources

Jenkins X likes to use GitOps to manage the lifecycle of both infrastructure and cluster resources.  This requires two Git Repositories to achieve this:
- **Infrastructure git repository**: infrastructure resources will be managed by Terraform and will keep resources in sync.
- **Cluster git repository**: the Kubernetes specific cluster resources will be managed by Jenkins X and keep resources in sync.

# Prerequisites

- A Git organisation that will be used to create the GitOps repositories used for Jenkins X below.
  e.g. https://github.com/organizations/plan.
- Create a git bot user (different from your own personal user)
  e.g. https://github.com/join
  and generate a a personal access token, this will be used by Jenkins X to interact with git repositories.
  e.g. https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo,admin:repo_hook

- __This bot user needs to have write permission to write to any git repository used by Jenkins X.  This can be done by adding the bot user to the git organisation level or individual repositories as a collaborator__
  Add the new `bot` user to your Git Organisation, for now give it Owner permissions, we will reduce this to member permissions soon.
- Check and install latest `terraform` CLI - [see here](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- Check and install latest `jx` CLI - [see here](https://jenkins-x.io/v3/admin/setup/jx3/)
- Check and install latest `gcloud` CLI - [see here](https://cloud.google.com/sdk/docs/install)
- Setup local `gcloud` auth so that Terraform can work with GCP
```bash
gcloud auth application-default login
```
- Google cloud container services has to be enabled
```bash
gcloud services enable container.googleapis.com
```

# Git repositories

We use 2 git repositories:

* **Infrastructure** git repository for the Terraform configuration to setup/upgrade/modify your cloud infrastructure (kubernetes cluster, IAM accounts, IAM roles, buckets etc)
* **Cluster** git repository to contain the `helmfile.yaml` file to define the helm charts to deploy in your cluster

We use separate git repositories since the infrastructure tends to change rarely; whereas the cluster git repository changes alot (every time you add a new quickstart, import a project, release a project etc).

Often different teams look after infrastructure; or you may use tools like Terraform Cloud to process changes to infrastructure & review changes to infrastructure more closely than promotion of applications.

# Getting started

__Note: remember to create the Git repositories below in your Git Organisation rather than your personal Git account else this will lead to issues with ChatOps and automated registering of webhooks__.

1. Create an **Infrastructure** git repo from this GitHub Template https://github.com/jx3-gitops-repositories/jx3-terraform-gke/generate.  If you are following from the Jenkins X website then this initial step may have already happened.

    __Note:__ Ensure **Owner** is the name of the Git Organisation that will hold the GitOps repositories used for Jenkins X.

2. Create a **Cluster** git repository; choosing your desired secrets store, either Google Secret Manager or Vault:
    - __Google Secret Manager__: https://github.com/jx3-gitops-repositories/jx3-gke-gsm/generate 
    __Note:__ If you choose Google Secret Manager, billing must be activated on your acccount!
    

    - __Vault__: https://github.com/jx3-gitops-repositories/jx3-gke-vault/generate
    
    __Note:__ Ensure **Owner** is the name of the Git Organisation that will hold the GitOps repositories used for Jenkins X.

3. You need to configure the git URL of your **Cluster** git repository (which contains `helmfile.yaml`) into the **Infrastructure** git repository (which contains `main.tf`). 

So from inside a git clone of the **Infrastructure** git repository (which already has the files `main.tf` and `values.auto.tfvars` inside) you need to link to the other **Cluster** repository (which contains `helmfile.yaml`) by committing the required terraform values from below to your `values.auto.tfvars`, e.g.

```sh
cat <<EOF >> values.auto.tfvars    
jx_git_url = "https://github.com/$git_owner_from_cluster_template_above/$git_repo_from_cluster_template_above"
gcp_project = "my-gcp-project"
EOF
```
If using Google Secret Manager (not Vault) cluster template from above enable it for Terraform using:
```sh
cat <<EOF >> values.auto.tfvars 
gsm = true
EOF
```

The contents of your `values.auto.tfvars` file should look something like this (the last line will be omitted if not using gsm)....

```terraform
resource_labels = { "provider" : "jx" }
jx_git_url = "https://github.com/myowner/myname-cluster"
gcp_project = "my-gcp-project"
gsm = true
```

4. commit and push any changes to your **Infrastructure** git repository:

```sh
git commit -a -m "fix: configure cluster repository and project"
git push
```

5. Now define 2 environment variables to pass the bot user and token into Terraform:

```sh
export TF_VAR_jx_bot_username=my-bot-username
export TF_VAR_jx_bot_token=my-bot-token
```

6. Now, initialise, plan and apply Terraform:

```sh
terraform init
```

```sh
terraform plan
```

```sh
terraform apply
```

Connect to the cluster
```
$(terraform output connect)
```
Tail the Jenkins X installation logs
```
$(terraform output follow_install_logs)
```
Once finished you can now move into the Jenkins X Developer namespace

```sh
jx ns jx
```

and create or import your applications

```sh
jx project
```

## Terraform Inputs

For the full list of terraform inputs [see the documentation for jenkins-x/terraform-google-jx](https://github.com/jenkins-x/terraform-google-jx#inputs)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apex\_domain\_integration\_enabled | Add recordsets from a subdomain to a parent / apex domain | `bool` | `true` | no |
| cluster\_location | The location (region or zone) in which the cluster master will be created. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region | `string` | `"us-central1-a"` | no |
| cluster\_name | Name of the Kubernetes cluster to create | `string` | `""` | no |
| force\_destroy | Flag to determine whether storage buckets get forcefully destroyed | `bool` | `false` | no |
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
| parent\_domain\_gcp\_project | The GCP project the parent domain is managed by, used to write recordsets for a subdomain if set.  Defaults to current project. | `string` | `""` | no |
| resource\_labels | Set of labels to be applied to the cluster | `map(string)` | `{}` | no |
| subdomain | Optional sub domain for the installation | `string` | `""` | no |
| tls\_email | Email used by Let's Encrypt. Required for TLS when parent\_domain is specified | `string` | `""` | no |

# Cleanup

To remove any cloud resources created here run:
```sh
terraform destroy
```

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
