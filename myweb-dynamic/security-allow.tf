resource "aws_security_group" "allow_ssh" {
  name        = "tf_Remote_Provisioner"
  description = "Allow SSH and HTTP Inbound Traffic"


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Run http server"
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable  SSh"
  }

# Outboud Rule for install softwares
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Remote_Provisioner"
  }
}
