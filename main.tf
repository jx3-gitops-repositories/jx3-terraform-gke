module "jx" {
  source                          = "github.com/jenkins-x/terraform-google-jx?ref=v1.10.0"
  gcp_project                     = var.gcp_project
  jx2                             = false
  gsm                             = var.gsm
  cluster_name                    = var.cluster_name
  cluster_location                = var.cluster_location
  resource_labels                 = var.resource_labels
  node_machine_type               = var.node_machine_type
  min_node_count                  = var.min_node_count
  max_node_count                  = var.max_node_count
  node_disk_size                  = var.node_disk_size
  node_disk_type                  = var.node_disk_type
  tls_email                       = var.tls_email
  lets_encrypt_production         = var.lets_encrypt_production
  jx_git_url                      = var.jx_git_url
  jx_bot_username                 = var.jx_bot_username
  jx_bot_token                    = var.jx_bot_token
  force_destroy                   = var.force_destroy
  apex_domain                     = var.apex_domain
  subdomain                       = var.subdomain
  apex_domain_gcp_project         = var.apex_domain_gcp_project
  apex_domain_integration_enabled = var.apex_domain_integration_enabled

}

output "connect" {
  description = "Connect to cluster"
  value       = module.jx.connect
}

output "follow_install_logs" {
  description = "Follow Jenkins X install logs"
  value       = "jx admin log"
}

output "docs" {
  description = "Follow Jenkins X 3.x alpha docs for more information"
  value       = "https://jenkins-x.io/v3/"
}
