locals {
  cloudinit = <<EOF
#!/bin/bash -x
echo "${var.password}" | passwd opc --stdin
EOF
}
