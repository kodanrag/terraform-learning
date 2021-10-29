# This code is to demo TF variables and tfvars

provider "aws" {
	region = var.region
}

resource "aws_instance" "tf_lab7_instance" {
	instance_type = var.instance_type
	ami = var.image_id
	tags = {
		Name = var.tag_name
		Environment = var.tag_env
	}
}

