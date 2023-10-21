# Provider configuration for AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "docker_vpc" {
  cidr_block = var.vpc_cidr
}


#creating internet gateway
resource "aws_internet_gateway" "docker_igw" {
  vpc_id = aws_vpc.docker_vpc.id

}



# Create a public subnet
resource "aws_subnet" "public_subnet_docker" {
  vpc_id                  = aws_vpc.docker_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_subnet_availability_zone
  map_public_ip_on_launch = true
}

# Create a private subnet
resource "aws_subnet" "private_subnet_docker" {
  vpc_id            = aws_vpc.docker_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_availability_zone
}

# Create a security group for your Docker registry
resource "aws_security_group" "docker_registry_sg" {
name = "security"
description = "Security group for Docker registry EC2 instance"
vpc_id = aws_vpc.docker_vpc.id

  # Define ingress and egress rules as needed for your use case
  # For example, you might need to open port 5000 for your Docker registry
 ingress {
    from_port   = var.docker_registry_ingress_port
    to_port     = var.docker_registry_ingress_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open port 22 for SSH (you might want to restrict this for production)
  #ingress {
  # from_port   = 22
  #to_port     = 22
  #protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #}

  # Define egress rules as needed
  egress {
    from_port   = 0
    to_port     = 0     # Allow all outbound traffic
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]    # Allow traffic to any destination
  }
}

# Create an EC2 instance for your Docker registry
resource "aws_instance" "docker_registry" {
  ami             = var.docker_registry_ami
  instance_type   = var.docker_registry_instance_type
  subnet_id       = aws_subnet.private_subnet_docker.id
  security_groups = [aws_security_group.docker_registry_sg.id]
  

  # You can customize the user data script to set up your Docker registry on launch
  #user_data = var.docker_registry_user_data
}
