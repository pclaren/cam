#####################################################################
##
##      Created 07/05/2020 by admin. for test-cam-project
##
#####################################################################
variable "ssh_key" {}
variable "hostname" {}

terraform {
  required_version = "> 0.8.0"
}

# Key pair for Ansible user
resource "tls_private_key" "keyPairForAnsibleUser" {
 algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "ansible_ssh_key" {
    public_key          = "${tls_private_key.keyPairForAnsibleUser.public_key_openssh}"
    label               = "camKeyForAnsibleUser"
}

# Public key to upload to VM
resource "ibm_compute_ssh_key" "my_ssh_key" {
    public_key          = "${var.ssh_key}"
    label               = "camKeyForUser"
}

provider "ibm" {
  version = "~> 0.7"
}

resource "ibm_compute_vm_instance" "vm1" {
  cores                  = 1
  memory                 = 2048
  domain                 = "CPAT-UKI.cloud"
  hostname               = "${var.hostname}"
  datacenter             = "lon02"
  ssh_key_ids            = ["${ibm_compute_ssh_key.ansible_ssh_key.id}", "${ibm_compute_ssh_key.my_ssh_key.id}"]
  os_reference_code      = "CENTOS_7_64"
  network_speed          = 100
  hourly_billing         = true
  private_network_only   = false
  disks                  = [25]
  local_disk             = true
}
