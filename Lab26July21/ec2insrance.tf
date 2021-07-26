## This is to create AWS EC2 instance and store terrform.tfstate to S3 bucket

terraform {
  backend "s3" {
    bucket = "practice-chiru"
    key = "terraform/keys/terraform.tfstate"
    region = "us-east-1"
  }
}
resource "aws_instance" "test_host" {
  ami = "ami-074df373d6bafa625"
  instance_type = "t2.micro"

  tags = {
    name  = "test_host"
  }
}

provider "aws" {
  region = "us-east-1"
}