<!---
Copyright IBM Corp. 2018, 2018
--->

# IBM Cloud Private on Openshift Container Platform

The IBM Cloud Private on Openshift Container Platform Terraform template and inline modules will install prerequisites and install the IBM Cloud Private product on top of an Openshift Container Platform within you vmWare Hypervisor enviroment.

This template will install and configure the IBM Cloud Private.

The components of a IBM Cloud Private deployment include:

- Management Node (1 Node, one of OCP's Compute Nodes)
- Master Nodes (1 Node, one of OCP's Compute Nodes)
- Proxy Nodes (1 Ndode, one of OCP's Compute Nodes)

For more infomation on IBM Cloud Private Nodes, please reference the Knowledge Center: <https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/getting_started/architecture.html>

## IBM Cloud Private Versions

| ICP Version | GitTag Reference|
|------|:-------------:|
| 3.2.0  | 3.2.0|

<https://github.com/IBM-CAMHub-Open/template_icp_on_ocp>

## System Requirements

### Hardware requirements

IBM Cloud Private nodes must meet the following requirements:
<https://www.ibm.com/support/knowledgecenter/en/SSBS6K_3.2.0/supported_system_config/hardware_reqs.html>

This template will setup the following hardware minimum requirements:

| Node Type | CPU Cores | Memory (mb) | Disk 1 | Disk 2 | Number of hosts |
|------|:-------------:|:----:|:-----:|:-----:|:-----:|
| Management | 4 | 16384 | 200 | n/a | 1 |
| Master  | 12 | 32768 | 300 | n/a | 1 |
| Proxy | 2 | 8192 | 200 | n/a | 1 |

### Supported operating systems and platforms

The following operating systems and platforms are supported.

***Ubuntu 16.04 LTS***

- VMware Tools must be enabled in the image for VMWare template.
- Ubuntu Repos with correct configuration must be enabled in the images.
- Sudo User and password must exist and be allowed for use.
- Firewall (via iptables) must be disabled.
- SELinux must be disabled.
- The system umask value must be set to 0022.
