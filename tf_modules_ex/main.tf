# This code is to demo tf modules
locals {
	instance_type = "t2.micro"
	image_id = "ami-02e136e904f3da870"
	tag_name = "Raghu"
	tag_env = "dev"
}

provider "aws" {
	region = var.region
}

module "windows" {
	instance_type = local.instance_type
	image_id = local.image_id
	tag_name = local.tag_name
	tag_env = local.tag_env
	source = "./ec2-module"
}

