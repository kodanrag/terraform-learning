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
  vpc_id     = aws_vpc.raghu_vpc_name.id
  cidr_block = var.raghu_subnet_pub_cidr_block
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
  route_table_id            = aws_route_table.raghu_route_table_pub.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.raghu_internet_gateway.id
}

resource "aws_route_table_association" "raghu_internet_gateway_pub_association" {
  gateway_id     = aws_internet_gateway.raghu_internet_gateway.id
  route_table_id = aws_route_table.raghu_route_table_pub.id
}

resource "aws_route_table_association" "raghu_subnet_pub_association" {
  subnet_id      = aws_subnet.raghu_subnet_pub_name.id
  route_table_id = aws_route_table.raghu_route_table_pub.id
}
