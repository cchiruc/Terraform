resource "aws_instance" "Frontend_server"  {
  ami = "ami-074df373d6bafa625"
    instance_type = "t2.micro"
}

