resource "oci_load_balancer" "lb1" {
  shape          = "10Mbps"
  compartment_id = var.compartment_ocid
  subnet_ids = [ var.reddmz ] 
  display_name = "${var.apodo}lb"
  #network_security_group_ids = [var.gruposec]
}

resource "oci_load_balancer_backend_set" "lb-bes1" {
  name             = "lb-bes1"
  load_balancer_id = oci_load_balancer.lb1.id
  policy           = "ROUND_ROBIN"
  health_checker {
    port                = "80"
    protocol            = "HTTP"
    url_path            = "/"
    response_body_regex = ".*"
    interval_ms         = "10000"
    timeout_in_millis   = "4000"
    retries             = "3"
    return_code         = "200"
  }
}



resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = oci_load_balancer.lb1.id
  name                     = "http"
  port                     = 80
  protocol                 = "HTTP"
  default_backend_set_name = oci_load_balancer_backend_set.lb-bes1.name
}

resource "oci_load_balancer_backend" "test_backend" {
        count = var.cantidad
	backendset_name = oci_load_balancer_backend_set.lb-bes1.name
	ip_address = oci_core_instance.c[count.index].private_ip
	load_balancer_id = oci_load_balancer.lb1.id
	port = 80
	#backup =
	#drain = 
	#offline =
	#weight =
}

locals {
   lb_ip = oci_load_balancer.lb1.ip_address_details[0].ip_address
}
output "lb_ip" {
   value = local.lb_ip
}
