resource "aws_instance" "rpsweb" {
  ami                    = "ami-0aff18ec83b712f05"  # change  id matches to ubuntu linux
  instance_type          = "t2.micro"
  key_name               = "web-server"  # provide the same key as  created in dashboard
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "ubuntu-websever"   # change the name
  }

provisioner "file" {
    source      = "C:\\Users\\Administrator\\jpmc-terraform\\ubuntu-webserver\\apache2.sh"
    destination = "/tmp/apache2.sh"
  }
  # Change permissions on bash script and execute from ec2-instance.
  provisioner "remote-exec" {
    inline = [
      "chmod +x  /tmp/apache2.sh",
      "sudo /tmp/apache2.sh",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    # insecure    = "true"
    private_key = file("C:\\Users\\Administrator\\jpmc-terraform\\ubuntu-webserver\\web-server.pem")
    host        = self.public_ip
  }
}

output "instance_public_ip" {
  value = aws_instance.rpsweb.public_ip
}

