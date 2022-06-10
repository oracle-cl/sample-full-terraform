locals {
  cloudinit = <<EOF
#!/bin/bash -x
echo "${password}\n${password}" | passwd opc
EOF
}
