resource "aws_instance" "Frontend_server"  {
  ami = "ami-074df373d6bafa625"
    instance_type = "t2.micro"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_security_group" "allow_all_test" {
  name = "test_nsg"
  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 10000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]

  }
}

