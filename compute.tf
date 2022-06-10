resource oci_core_instance c {
  count               = var.cantidad
  availability_domain = var.adomain
  compartment_id      = var.compartment_ocid
  create_vnic_details {
    assign_public_ip = "false"
    display_name = "${var.apodo}_app_${count.index}"
    hostname_label = "${var.apodo}-app-${count.index}"
    skip_source_dest_check = "true"
    subnet_id              = var.redapp
  }
  display_name = "${var.apodo}_app_${count.index}"
  metadata = { 
      ssh_authorized_keys = local.ssh_public_key
      user_data = base64encode(local.cloudinit)
  }
  shape = var.shape
  shape_config {
    ocpus = var.ocpu
    memory_in_gbs = var.memoria
  }
  source_details {
    source_type = "image"
    source_id   = local.imagen_dev
  }
  lifecycle {
    ignore_changes = [ metadata ]
  }
}
