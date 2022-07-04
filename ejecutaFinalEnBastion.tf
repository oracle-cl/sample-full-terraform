resource null_resource ejecuta_configura {
  triggers = {
    always_run = "${timestamp()}"
    script_final = local.script_final
  }

  connection {
    type        = "ssh"
    user        = "opc"
    private_key = local.ssh_private_key
    host        = local.ip_bastion
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "${local.script_final}"
    ]
  }
}
resource null_resource ejecuta_final {
  triggers = {
    script_final = null_resource.ejecuta_configura.id
    always_run = "${timestamp()}"
  }

  connection {
    type        = "ssh"
    user        = "opc"
    private_key = local.ssh_private_key
    host        = local.ip_bastion
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${null_resource.ejecuta_configura.id}",
      "cd sample-full-ansible",
      "ansible-playbook -i lista_hosts inicia.yaml -v -T 300"
    ]
  }
}
