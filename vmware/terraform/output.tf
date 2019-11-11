resource "random_id" "clusterid" {
  byte_length = "2"
}

output "ibm_cloud_private_admin_url" {
  value = "https://icp-console.${var.ocp_infra_ip}.nip.io"
}

output "ocp_infra_ip" {
  value = "${var.ocp_infra_ip}"
}

output "ibm_cloud_private_admin_user" {
  value = "${var.icp_admin_user}"
}

output "ibm_cloud_private_admin_password" {
  value = "${var.icp_admin_password}"
}

output "ibm_cloud_private_boot_ip" {
  value = "${var.ocp_master_ip}"
}

output "docker_reg_token" {
  value = "${camc_scriptpackage.get_token.result["stdout"]}"
}