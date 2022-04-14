resource "oci_database_autonomous_database" "adb" {
	#Required
	compartment_id = var.compartment_ocid
	db_name = var.apodo
	subnet_id = var.reddata
	admin_password = var.password
	cpu_core_count = 1
	data_storage_size_in_tbs = 1
	db_workload = "OLTP"
	#are_primary_whitelisted_ips_used = 
	#autonomous_container_database_id = 
	#autonomous_database_backup_id =
	#autonomous_database_id = oci_database_autonomous_database.test_autonomous_database.id
	#autonomous_maintenance_schedule_type = var.autonomous_database_autonomous_maintenance_schedule_type
	#clone_type = var.autonomous_database_clone_type
	#customer_contacts {
		#email =
	#}
	#data_safe_status =
	#data_storage_size_in_gb =
	#db_version =
	#defined_tags =
	#display_name =
	#freeform_tags =
	#is_access_control_enabled = false
	#is_auto_scaling_enabled =
	#is_data_guard_enabled =
	#is_dedicated =
	#is_free_tier =
	#is_mtls_connection_required =
	#is_preview_version_with_service_terms_accepted =
	#kms_key_id =
	#license_model =
	nsg_ids = [ var.nsg ]
	#ocpu_count =
	#private_endpoint_label =
	#refreshable_mode =
	#scheduled_operations {
	#	day_of_week {
	#		name =
	#	}
        #	scheduled_start_time =
        #	scheduled_stop_time =
        #	}
        #source =
	#source_id =
	#standby_whitelisted_ips =
	#timestamp =
	#vault_id =
	#whitelisted_ips =
}

locals {
   adb = oci_database_autonomous_database.adb.connection_strings[0].all_connection_strings.MEDIUM
}
output "adb" {
   value = local.adb
}
