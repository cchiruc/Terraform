#To create EC2 spot intances.
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
    to_port          = 10000
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "allow_project_roboshop"
  }
}
//tags creation for EC2 instance
resource "aws_ec2_tag" "roboshop_instance" {
  depends_on = [aws_route53_record.roboshop_internal]
  count       = length(var.COMPONENTS)
  resource_id = element(aws_spot_instance_request.project_roboshop.*.spot_instance_id,count.index)
  key         = "Name"
  value       = element(var.COMPONENTS, count.index )
}
# pull the shall scripting code for installtion and configration of roboshop applicaitons.
resource "aws_route53_record" "roboshop_internal" {
  depends_on = [aws_spot_instance_request.project_roboshop]
  count   = length(var.COMPONENTS)
  zone_id = "Z04635172URQKFFOUCBQ5"
  name    = element(var.COMPONENTS,count.index )
  type    = "A"
  ttl     = "300"
  records = [element(aws_spot_instance_request.project_roboshop.*.private_ip,count.index )]
}

## Defining shell-scripts for execution.
resource "null_resource" "chiru-scripts" {
  depends_on = [aws_route53_record.roboshop_internal]
  count = length(var.COMPONENTS)
  provisioner "remote-exec" {
    connection {
      host = element(aws_spot_instance_request.project_roboshop.*.private_ip, count.index )
      user = "centos"
      password = "DevOps321"
    }

    inline = [
      "cd /home/centos",
      "git clone https://github.com/Polina-DevOps/Shell-Scripts.git",
      "cd /home/centos/Shell-Scripts/Roboshop-Init",
      "sudo make ${element(var.COMPONENTS,count.index )}"
    ]
  }
}