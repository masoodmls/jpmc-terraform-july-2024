terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 4.0"
    }
  }
}

resource "aws_instance" "example_server" {
  ami           = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"

  tags = {
    Name = "jpmc-ec2"
  }
}
