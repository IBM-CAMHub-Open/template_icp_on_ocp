provider "vsphere" {
  version              = "~> 1.3"
  allow_unverified_ssl = "true"
}

provider "random" {
  version = "~> 1.0"
}

provider "local" {
  version = "~> 1.1"
}

provider "null" {
  version = "~> 1.0"
}

provider "tls" {
  version = "~> 1.0"
}

resource "random_string" "random-dir" {
  length  = 8
  special = false
}

resource "tls_private_key" "generate" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "null_resource" "create-temp-random-dir" {
  provisioner "local-exec" {
    command = "${format("mkdir -p  /tmp/%s" , "${random_string.random-dir.result}")}"
  }
}

module "icp_download_load" {
  source                 = "git::https://github.com/IBM-CAMHub-Open/template_icp_modules.git?ref=2.3.47//config_icp_on_ocp_download"

  private_key            = "${length(var.icp_private_ssh_key) == 0 ? "${tls_private_key.generate.private_key_pem}" : "${base64decode(var.icp_private_ssh_key)}"}"
  vm_os_password         = "${var.installer_vm_os_password}"
  vm_os_user             = "${var.installer_vm_os_user}"
  ocp_installer                = "${element(keys(var.ocp_master_host_ip),0)}.${var.ocp_vm_domain_name}"
  icp_url                = "${var.icp_binary_url}"
  icp_version            = "${var.icp_version}"
  download_user          = "${var.download_user}"
  download_user_password = "${var.download_user_password}"
  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"  
  #######    
  random                 = "${random_string.random-dir.result}"
}

module "icp_config_yaml" {
  source                 = "git::https://github.com/IBM-CAMHub-Open/template_icp_modules.git?ref=2.3.47//config_icp_on_ocp_boot"

  private_key            = "${length(var.icp_private_ssh_key) == 0 ? "${tls_private_key.generate.private_key_pem}" : "${base64decode(var.icp_private_ssh_key)}"}"
  vm_os_password         = "${var.installer_vm_os_password}"
  vm_os_user             = "${var.installer_vm_os_user}"
  ocp_installer                = "${element(keys(var.ocp_master_host_ip),0)}.${var.ocp_vm_domain_name}"
  icp_version            = "${var.icp_version}"
  icp_cluster_name       = "${var.icp_cluster_name}"
  icp_admin_user         = "${var.icp_admin_user}"
  icp_admin_password     = "${var.icp_admin_password}"

  icp_master_host        = "${element(keys(var.icp_master_host_ip),0)}"
  icp_proxy_host         = "${var.icp_proxy_host}"
  icp_management_host    = "${var.icp_management_host}"
  ocp_master_host        = "${element(keys(var.ocp_master_host_ip),0)}"
  ocp_vm_domain_name     = "${var.ocp_vm_domain_name}"
  ocp_enable_glusterfs   = "${var.ocp_enable_glusterfs}"
  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"  
  #######    
  random                 = "${random_string.random-dir.result}"
  dependsOn              = "${module.icp_download_load.dependsOn}"
}

module "icp_config_output" {
  dependsOn             = "[${module.icp_config_yaml.dependsOn}]"
  source                = "git::https://github.com/IBM-CAMHub-Open/template_icp_modules.git?ref=2.3//config_icp_ocp_output"
  vm_os_private_key     = ""
  vm_os_password        = "${var.installer_vm_os_password}"
  vm_os_user            = "${var.installer_vm_os_user}"
  master_node_ip        = "${element(values(var.icp_master_host_ip),0)}"
  cluster_name			= "${var.icp_cluster_name}"
  api_server			= "${element(values(var.icp_master_host_ip),0)}"
  api_port				= "8001"
  reg_server			= "docker-registry.default.svc"
  reg_port				= "5000"
  icp_admin_user        = "${var.icp_admin_user}"
  #######
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_host_key    = "${var.bastion_host_key}"
  bastion_password    = "${var.bastion_password}"
  #######      
}

resource "camc_scriptpackage" "get_home_dir" {
  depends_on = ["module.icp_config_yaml"]
  program = ["echo $HOME"]
  on_create = true
  remote_host = "${element(values(var.ocp_master_host_ip),0)}"
  remote_user = "${var.installer_vm_os_user}"
  remote_password = "${var.installer_vm_os_password}"
  remote_key = ""
  bastion_host        = "${var.bastion_host}"
  bastion_user        = "${var.bastion_user}"
  bastion_private_key = "${var.bastion_private_key}"
  bastion_port        = "${var.bastion_port}"
  bastion_password    = "${var.bastion_password}"
}
