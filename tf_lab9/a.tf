# This code is to demo tf modules

provider "aws" {
	region = var.region
}

module "windows" {
        instance_type = local.instance_type
	ami = local.image_id
#        ami = var.image_id
	source = "./ec2-module"
	
}

