
variable instance_type {}
variable public_key_location {}
variable private_key_location {}
variable env_prefix {}


# fetch the information about ubuntu linux ami details

data "aws_ami" "latest-ubuntu-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name" 
  
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws-ami_id" {
  value = data.aws_ami.latest-ubuntu-linux-image.id
}

# creating the ec2 instance
output "ec2-public_ip" {
  value = aws_instance.myapp-server.public_ip
}

resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"        # key to be created under aws key pairs
  public_key = file(var.public_key_location)
}

resource "aws_instance" "myapp-server" {
  ami =  data.aws_ami.latest-ubuntu-linux-image.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name
 vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name: "${var.env_prefix}-server"
  }
provisioner "file" {
    source      = "C:\\Users\\Administrator\\jpmc-terraform\\myweb-dynamic\\apache2.sh"
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
    private_key = file(var.private_key_location)
    host        = self.public_ip
  }
}