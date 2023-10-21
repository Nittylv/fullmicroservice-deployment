variable "aws_region" {
  description = "AWS region where the resources will be created"
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_availability_zone" {
  description = "Availability zone for the public subnet"
  default     = "us-east-2a"
}

variable "private_subnet_availability_zone" {
  description = "Availability zone for the private subnet"
  default     = "us-east-2b"
}

variable "docker_registry_ingress_port" {
  description = "Port for Docker registry ingress"
  default     = 5000
}

variable "docker_registry_ami" {
  description = "AMI for the Docker registry EC2 instance"
  default     = "ami-083ac598d805fbb10" # for ubuntu 20

}

variable "docker_registry_instance_type" {
  description = "EC2 instance type for the Docker registry"
  default     = "t2.micro"
}

#variable "docker_registry_user_data" {
#  description = "User data script for setting up the Docker registry"
#  default = <<-EOF
#              #!/bin/bash
#              # Your user data script here for setting up the Docker registry
#              EOF
#}
