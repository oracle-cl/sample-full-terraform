locals {
   globales = <<-EOF
     ansible_ssh_private_key_file: "/home/opc/.ssh/id_rsa"
     ansible_ssh_user: "opc"
     ambiente: "${var.apodo}"
     tns: "${local.adb}"
     password: "${var.password}"
     lb_ip: "${local.lb_ip}"
     EOF
   paso = [ for i in oci_core_instance.c : i.private_ip ]
   linux = <<-EOF
     [bastion]
     localhost ansible_connection=local
     [linux]
     ${join("\n", local.paso )}
     EOF
   test_autonomous = <<-EOF
     #!/bin/bash 
     export TNS_ADMIN=/home/opc/tns
     sqlplus admin/${var.password}@${var.apodo}_medium
     EOF
   ssh_config = <<-EOF
     Host *
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
     EOF
   script_final = <<-EOF
      echo '${var.ssh_public_key}' >> .ssh/authorized_keys
      echo '${local.ssh_private_key}' > .ssh/id_rsa
      echo '${local.ssh_config}' > .ssh/config
      chmod 0600 .ssh/*
      rm -r -f sample-full-ansible
      sudo yum install -y git ansible
      git clone https://github.com/oracle-cl/sample-full-ansible.git
      cd sample-full-ansible
      echo '${local.globales}' > globales.yaml
      echo '${local.linux}' > lista_hosts
      echo '${local.zip_file}' > roles/tns/files/wallet.zip.base64
      echo '${local.test_autonomous}' > test_autonomous.sh
      echo FIN CONFIG Inicial
      EOF
}
