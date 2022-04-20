resource oci_core_instance bastion {
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
  }
  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = var.adomain
  compartment_id = var.compartment_ocid
  create_vnic_details {
    assign_public_ip = "true"
    display_name = "${var.apodo}_bastion"
    skip_source_dest_check = "true"
    subnet_id              = var.reddmz
    hostname_label = "bastion"
  }

  display_name = "${var.apodo}_bastion"
  metadata = { 
          ssh_authorized_keys = local.ssh_public_key 
          }
  extended_metadata = { 
       apodo     = var.apodo
       }
  #preserve_boot_volume = true
  shape = "VM.Standard.E4.Flex"
  shape_config {
    ocpus = 1
    memory_in_gbs = 8
  }
  source_details {
    source_type = "image"
    source_id   = local.imagen_dev
  }
  lifecycle {
    ignore_changes = [ metadata, extended_metadata , defined_tags ]
  }
}


locals {
   ip_bastion = oci_core_instance.bastion.public_ip
}
output "bastion" {
   value = local.ip_bastion
}

