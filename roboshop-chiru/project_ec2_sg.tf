#To create EC2 spot intance.
#price 0.03
resource "aws_spot_instance_request" "project_roboshop" {
  count         = length(var.COMPONENTS)
  ami           = "ami-074df373d6bafa625"
  instance_type = "t2.micro"
  spot_price    = "0.03"
}
resource "aws_security_group" "allow_project_roboshop" {
  name        = "allow_project_roboshop"
  description = "Allow all TLS inbound traffic"

  ingress {
    description      = "allow all inbound traffic"
    from_port        = 0
    to_port          = 10000
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
    Name = "allow_project_roboshop"
  }
}
//tags creation for EC2 instance
resource "aws_ec2_tag" "roboshop instance" {
  count       = length(var.COMPONENTS)
  resource_id = element(aws_spot_instance_request.project_roboshop.*.spot_instance_id,count.index)
  key         = "Name"
  value       = element(var.COMPONENTS,count.index )
}



