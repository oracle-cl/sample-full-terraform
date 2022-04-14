resource "oci_database_autonomous_database_wallet" "w" {
  autonomous_database_id = oci_database_autonomous_database.adb.id
  password               = var.password
  base64_encode_content  = "true"
}

locals {
  zip_file = oci_database_autonomous_database_wallet.w.content
}
