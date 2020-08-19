module "jx" {
  source                  = "github.com/jenkins-x/terraform-google-jx?ref=gsm"
  gcp_project             = var.gcp_project
  jx2                     = false
  gsm                     = var.gsm
  cluster_name            = var.cluster_name
  cluster_location        = var.cluster_location
  resource_labels         = var.resource_labels
  node_machine_type       = var.node_machine_type
  min_node_count          = var.min_node_count
  max_node_count          = var.max_node_count
  node_disk_size          = var.node_disk_size
  node_disk_type          = var.node_disk_type
  parent_domain           = var.parent_domain
  tls_email               = var.tls_email
  lets_encrypt_production = var.lets_encrypt_production
}

output "connect" {
  description = "Connect to cluster"
  value       = "connect to your cluster using `${module.jx.connect}`"
}

output "set_env_1" {
  description = "Set the GCP project environment variable"
  value       = "export PROJECT_ID=${module.jx.gcp_project}"
}

output "set_env_2" {
  description = "Set the cluster name environment variable"
  value       = "export CLUSTER_NAME=${module.jx.cluster_name}"
}

output "next" {
  description = "Follow instructions to enable Jenkins X install via GitOps"
  value       = "https://jenkins-x.io/docs/v3/getting-started/"
}
