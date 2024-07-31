resource "null_resource" "operation3" {
provisioner "local-exec" {
command = "echo ${var.myvar} for ${var.yourvar} days  ${var.newvar}   in vars file > file1.txt"
}
}


output "Variables_are" {
  value = "${var.myvar} ${var.yourvar}  days ${var.newvar}"
}