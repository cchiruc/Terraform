## To create AWS EC2 instance in Chiru AWS console
resource "aws_instance" "chiru_server" {
  ami           = "ami-074df373d6bafa625"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.chiru_allow_all.id]

  tags = {
    Name = "chiru_server"
  }
}

## Defining the region
provider "aws" {
  region  = "us-east-1"
}

resource "aws_security_group" "chiru_allow_all" {
  name        = "chiru_allow_all"
  description = "Allow all inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0-65556
protocol         = "tcp"
cidr_blocks      = ["0.0.0.0/0"]

}

egress {
from_port        = 0
to_port          = 0
protocol         = "-1"
cidr_blocks      = ["0.0.0.0/0"]

}

tags = {
Name = "chiru_allow_all"
}
}