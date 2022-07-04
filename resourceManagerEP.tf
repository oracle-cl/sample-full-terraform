resource oci_resourcemanager_private_endpoint rms_private_endpoint {
  compartment_id = var.compartment_ocid
  display_name   = "${var.apodo}-rms-endpoint"
  vcn_id         = var.vcn
  subnet_id      = var.reddmz
}
