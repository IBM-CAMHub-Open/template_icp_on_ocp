# Single Node
variable "installer_vm_os_user" {
  type = "string"
}

variable "installer_vm_os_password" {
  type = "string"
}

# SSH KEY Information
variable "icp_private_ssh_key" {
  type    = "string"
}

variable "icp_public_ssh_key" {
  type    = "string"
}

# Binary Download Locations

variable "icp_binary_url" {
  type = "string"
}

variable "icp_version" {
  type    = "string"
}

variable "download_user" {
  type = "string"
}

variable "download_user_password" {
  type = "string"
}

variable "icp_admin_user" {
  type    = "string"
}

variable "icp_admin_password" {
  type    = "string"
}

variable "icp_master_host_ip" {
  type = "map"
}

variable "icp_proxy_host" {
  type = "string"
}

variable "icp_management_host" {
  type = "string"
}

variable "ocp_master_host_ip" {
  type = "map"
}

variable "ocp_infra_ip" {
  type = "string"
}

variable "ocp_vm_domain_name" {
  type = "string"
}

variable "ocp_enable_glusterfs" {
  type = "string"
}

variable "icp_cluster_name" {
  type = "string"
}