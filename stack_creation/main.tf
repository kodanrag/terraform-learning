# This code is to demo new stack creation

provider "aws" {
  region = "us-east-1"
}

# Ref URL https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "raghu_vpc_name" {
  cidr_block       = var.raghu_vpc_cidr_block
  instance_tenancy = var.raghu_vpc_instance_tenancy

  tags = {
    Name = var.raghu_vpc_name
  }
}

# Ref URL https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "raghu_subnet_pub_name" {
  vpc_id                  = aws_vpc.raghu_vpc_name.id
  cidr_block              = var.raghu_subnet_pub_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = var.raghu_subnet_pub_name
  }
}

resource "aws_subnet" "raghu_subnet_pvt_name" {
  vpc_id     = aws_vpc.raghu_vpc_name.id
  cidr_block = var.raghu_subnet_pvt_cidr_block

  tags = {
    Name = var.raghu_subnet_pvt_name
  }
}

# Ref URL https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "raghu_internet_gateway" {
  vpc_id = aws_vpc.raghu_vpc_name.id

  tags = {
    Name = var.raghu_internet_gateway
  }
}

# Ref URL https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "raghu_route_table_pub" {
  vpc_id = aws_vpc.raghu_vpc_name.id

  tags = {
    Name = var.raghu_route_table_pub
  }
}

resource "aws_route" "raghu_route" {
  route_table_id         = aws_route_table.raghu_route_table_pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.raghu_internet_gateway.id
}

resource "aws_route_table_association" "raghu_subnet_pub_association" {
  subnet_id      = aws_subnet.raghu_subnet_pub_name.id
  route_table_id = aws_route_table.raghu_route_table_pub.id
}

resource "aws_security_group" "raghu_sg_pub" {
  name        = var.raghu_sg_pub
  description = var.raghu_sg_description
  vpc_id      = aws_vpc.raghu_vpc_name.id

  ingress = [
    {
      description = "Port 80 open to public"
      from_port   = var.raghu_http_port
      to_port     = var.raghu_http_port
      protocol    = var.raghu_protocol
      #cidr_blocks      = [aws_vpc.raghu_vpc_name.cidr_block]
      cidr_blocks = ["0.0.0.0/0"]
      #    ipv6_cidr_blocks = [aws_vpc.raghu_vpc_name.ipv6_cidr_block]
      #    ipv6_cidr_blocks = ["::/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description = "Port ssh open to Public subnet"
      from_port   = var.raghu_ssh_port
      to_port     = var.raghu_ssh_port
      protocol    = var.raghu_protocol
      #cidr_blocks      = [aws_vpc.raghu_vpc_name.cidr_block]
      cidr_blocks = ["0.0.0.0/0"]
      #    ipv6_cidr_blocks = [aws_vpc.raghu_vpc_name.ipv6_cidr_block]
      #    ipv6_cidr_blocks = ["::/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }

  ]

  egress = [
    {
      description = "TLS from VPC"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      #ipv6_cidr_blocks = ["::/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = var.raghu_sg_pub
  }
}

# IMPORTANT NOTE ON VAR W.R.T MODULES:

########## In root main.tf, consider variable example within a module block as below:
########## ami = var.raghu_ami
########## Here two things to be considred:
########## 1. Compulsorily define "raghu_ami" as a variable in root directory variable.tf
########## 2. Assign a value to "raghu_ami" using tfvars

########## In main.tf of the module directory, consider variable example within a resource block as below:
########## ami = var.ami
########## if we need to pick the value of the variable "ami" from the root main.tf
########## Here two things to be considered:
########## 1. Compulsorily define "ami" as a variable in module directory variable.tf
########## 2. value assignment  happenes from root.tf so no need to add in tfvars

locals {
	subnet_ids = [ aws_subnet.raghu_subnet_pub_name.id, aws_subnet.raghu_subnet_pvt_name.id ]
        ec2_names = [ "raghu_ec2_instance_pub" , "raghu_ec2_instance_pvt" ]
}

module "ec2_instance" {
  # source  = "terraform-aws-modules/ec2-instance/aws" # example for module registry
  source = "./ec2_instance/"

  ami                    = var.raghu_ami
  instance_type          = var.raghu_instance_type
  vpc_security_group_ids = aws_security_group.raghu_sg_pub.id
  subnet_id = local.subnet_ids
  Name                   = local.ec2_names
  Environment            = var.raghu_Environment
  user_datA              = file("install.sh")
  no_of_ec2		= var.raghu_no_of_ec2
}


