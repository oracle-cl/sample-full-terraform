data "oci_core_images" "lista_images" {
	compartment_id = var.compartment_ocid
	#Optional
	display_name = "Oracle-Linux-Cloud-Developer-8.4-2021.08.27-0"
	#operating_system = var.image_operating_system
	#operating_system_version = var.image_operating_system_version
	#shape = var.image_shape
	#state = var.image_state
	#sort_by = var.image_sort_by
        #sort_order = var.image_sort_order
}

locals {
   imagen_dev = data.oci_core_images.lista_images.images[0].id
}
