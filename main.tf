locals {
  vpc_id              = "vpc-0ab5d07a38f810ba9"
  subnet_id           = "subnet-02ef3020c2b43a59d"
  keyname             = "CIaCTS_key"
}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "hybrid-sg" {
  name = var.secgrp_name
  description = var.secgrp_name
  vpc_id = local.vpc_id

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "hybrid" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = local.subnet_id 
  associate_public_ip_address = true
  key_name = local.keyname

  user_data = "${file("init-script.sh")}"
    
  vpc_security_group_ids = [
    aws_security_group.hybrid-sg.id
  ]

  tags = {
    Name = var.instance_name
  }

  depends_on = [ aws_security_group.hybrid-sg ]
}
