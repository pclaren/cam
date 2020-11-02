#####################################################################
##
##      Created 07/05/2020 by admin. for test-cam-project
##
#####################################################################

# Output the public ipv4 address upon successful creation of the VM
 output "instance_ip_addr" {
   value                 = "${ibm_compute_vm_instance.vm1.ipv4_address}"
   description           = "The public IP address of the main server instance."
 }

output "private_key" {
   value                 = "${tls_private_key.keyPairForAnsibleUser.private_key_pem}"
   description           = "The private key of the main server instance."
   sensitive             = true
 }
