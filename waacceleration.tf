resource oci_waa_web_app_acceleration waa {
	backend_type = "LOAD_BALANCER"
	compartment_id = var.compartment_ocid
	load_balancer_id = oci_load_balancer.lb1.id
	web_app_acceleration_policy_id = oci_waa_web_app_acceleration_policy.waa_policy.id
	display_name = "${var.apodo}-waa"
}
resource oci_waa_web_app_acceleration_policy waa_policy {
	compartment_id = var.compartment_ocid
	display_name = "${var.apodo}-waa-policy"
	response_caching_policy {
		is_response_header_based_caching_enabled = true
	}
	response_compression_policy {
		gzip_compression {
			is_enabled = true
		}
	}
}
