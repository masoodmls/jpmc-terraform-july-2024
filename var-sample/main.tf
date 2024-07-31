resource "null_resource" "operation1" {
provisioner "local-exec" {
command = "echo ${var.myvar}  Terraform Rocks >> file1.txt"
}
}