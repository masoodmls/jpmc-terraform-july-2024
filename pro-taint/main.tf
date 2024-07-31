resource "aws_instance" "webserver" {
  ami           = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"

tags = {
    Name = "rps2-web"
}

  provisioner "local-exec" {
    command = "echo ${aws_instance.webserver.public_ip} >> ips.txt"
    on_failure = continue
  }
}
