data "oci_core_images" "lista_images" {
	compartment_id = var.compartment_ocid
	#display_name = 
	#operating_system = "Oracle Linux Cloud Developer"
	operating_system = "Oracle Linux"
	#operating_system_version 
	shape = "VM.Standard.E4.Flex"
	#state = 
	#sort_by = 
        #sort_order = 
}

data "oci_core_image_shapes" "shapes_images" {
        count = length(data.oci_core_images.lista_images.images)
        image_id = data.oci_core_images.lista_images.images[count.index].id
}
locals {
   imagen_dev = data.oci_core_images.lista_images.images[0].id
}

