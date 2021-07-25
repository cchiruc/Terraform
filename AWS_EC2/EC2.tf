## To create AWS EC2 instance in Chiru AWS console
resource "aws_instance" "chiru_server" {
  ami           = "ami-074df373d6bafa625"
  instance_type = "t2.micro"

  tags = {
    Name = "chiru_server"
  }
}

## Defining the region
provider "aws" {
  region  = "us-east-1"
}