// ----------------------------------------------------------------------------
// Required Variables
// ----------------------------------------------------------------------------
variable "gcp_project" {
  description = "The name of the GCP project to use"
  type        = string
}

// ----------------------------------------------------------------------------
// Optional Variables
// ----------------------------------------------------------------------------
variable "cluster_name" {
  description = "Name of the Kubernetes cluster to create"
  type        = string
  default     = ""
}

variable "cluster_location" {
  description = "The location (region or zone) in which the cluster master will be created. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region"
  type        = string
  default     = "us-central1-a"
}

variable "resource_labels" {
  description = "Set of labels to be applied to the cluster"
  type        = map(string)
  default     = {}
}

// ----------------------------------------------------------------------------
// cluster configuration
// ----------------------------------------------------------------------------
variable "node_machine_type" {
  description = "Node type for the Kubernetes cluster"
  type        = string
  default     = "n1-standard-2"
}

variable "min_node_count" {
  description = "Minimum number of cluster nodes"
  type        = number
  default     = 3
}

variable "max_node_count" {
  description = "Maximum number of cluster nodes"
  type        = number
  default     = 5
}

variable "node_disk_size" {
  description = "Node disk size in GB"
  type        = string
  default     = "100"
}

variable "node_disk_type" {
  description = "Node disk type, either pd-standard or pd-ssd"
  type        = string
  default     = "pd-standard"
}

variable "force_destroy" {
  description = "Flag to determine whether storage buckets get forcefully destroyed"
  type        = bool
  default     = false
}

variable "node_preemptible" {
  description = "Use preemptible nodes"
  type        = bool
  default     = false
}

variable "node_spot" {
  description = "Use spot nodes"
  type        = bool
  default     = false
}

// ----------------------------------------------------------------------------
// Ingress
// ----------------------------------------------------------------------------
variable "apex_domain" {
  description = "The apex / parent domain to be allocated to the cluster"
  type        = string
  default     = ""
}

variable "tls_email" {
  description = "Email used by Let's Encrypt. Required for TLS when parent_domain is specified"
  type        = string
  default     = ""
}

variable "lets_encrypt_production" {
  description = "Flag to determine wether or not to use the Let's Encrypt production server."
  type        = bool
  default     = true
}

variable "gsm" {
  description = "Enables Google Secrets Manager, not available with JX2"
  type        = bool
  default     = false
}

variable "jx_git_url" {
  description = "URL for the Jenins X cluster git repository"
  type        = string
}

variable "jx_bot_username" {
  description = "Bot username used to interact with the Jenkins X cluster git repository"
  type        = string
}

variable "jx_bot_token" {
  description = "Bot token used to interact with the Jenkins X cluster git repository"
  type        = string
}

variable "subdomain" {
  description = "Optional sub domain for the installation"
  type        = string
  default     = ""
}

variable "apex_domain_gcp_project" {
  description = "The GCP project the parent domain is managed by, used to write recordsets for a subdomain if set.  Defaults to current project."
  type        = string
  default     = ""
}

variable "apex_domain_integration_enabled" {
  description = "Add recordsets from a subdomain to a parent / apex domain"
  type        = bool
  default     = true
}

variable "kuberhealthy" {
  description = "Enables Kuberhealthy helm installation"
  type        = bool
  default     = true
}
