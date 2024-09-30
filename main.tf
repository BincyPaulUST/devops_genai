variable "aws_region" {
  description = "The AWS region where the EC2 instance will be created"
  type        = string
  default     = "us-west-2"
}

variable "ec2_instance_type" {
  description = "The EC2 instance type to be created"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c94855ba95c71c99"  # Amazon Linux 2 AMI (HVM), SSD Volume Type
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  tags = {
    Name = "EC2 Instance"
  }
}