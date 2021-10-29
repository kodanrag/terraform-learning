# This code is to demo outputs

provider "aws" {
	region = var.region
}

resource "aws_instance" "tf_lab8_instance" {
	instance_type = var.instance_type
	ami = var.image_id
	tags = {
		Name = var.tag_name
		Environment = var.tag_env
	}
}

