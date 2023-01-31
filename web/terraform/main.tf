terraform {
  
    required_version = ">= 0.12.0"

    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }

    backend "s3" {
    bucket = "terraform-my-own-pace-geanderson"
    key    = "terraform.tfstate"
    region = "us-east-1"
}


# Instance creation inside the VPC with public subnet

resource "aws_instance" "web" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name      = "geanderson"
  subnet_id     = var.web_subnet_public_id
  vpc_security_group_ids = []
  associate_public_ip_address = true
  tags = {
    Name = "web"
  }

resource "aws_security_group" "permitir_ssh_http" {
  name        = "permitir_ssh_http"
  description = "Permitir SSH e HTTP"
  vpc_id      = var.web_vpc_id

    ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
    Name = "permitir_ssh_http"
    }

}