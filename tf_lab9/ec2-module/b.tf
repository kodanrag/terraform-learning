# This code is to demo tf modules

provider "aws" {
	region = var.region
}

resource "aws_instance" "tf_lab9_instance" {
	instance_type = var.instance_type
	ami = var.image_id
	tags = {
		Name = var.tag_name
		Environment = var.tag_env
	}
}

# Below Data Block was taken from https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance and customized.

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
# To get below values run the following aws command:
# aws ec2 describe-images --owners amazon --image-ids <ami_id>
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

# To get below owners run the following aws command:
# aws ec2 describe-images --owners amazon --image-ids <ami_id>
  owners = ["801119661308"] # Canonical
}
