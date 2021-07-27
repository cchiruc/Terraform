## To create AWS Security group and EC2 instances for roboshop project

# Request a spot instance at $0.03

resource "aws_spot_instance_request" "cheap_worker" {
  count                      = length(var.COMPONENTS)
  ami                        = "ami-074df373d6bafa625"
  spot_price                 = "0.0035"
  instance_type              = "t2.micro"
  vpc_security_group_ids     = [aws_security_group.allow_roboshop.id]
  wait_for_fulfillment       = true

  tags = {
    Name = element(var.COMPONENTS, count.index )
  }
}

## AWS SG Creation
resource "aws_security_group" "allow_roboshop" {
  name        = "allow_roboshop"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
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
    Name = "allow_roboshop"
  }
}


## Assign name tags to the servers in roboshop project

resource "aws_ec2_tag" "roboshop_tag" {
  depends_on            = [aws_spot_instance_request.cheap_worker]
  count                 = length(var.COMPONENTS)
  resource_id           = aws_spot_instance_request.cheap_worker.spot_instance_id
  key                   = "Owner"
  value                 = element(var.COMPONENTS,count.index )
}