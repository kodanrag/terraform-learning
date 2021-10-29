# This code is to demo tf variable

provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "tf_lab6_instance" {
	instance_type = var.instance_type
        ami = "ami-02e136e904f3da870"
	tags = {
		Name = "tf_lab6_instance"
		Environment = "Dev"
	}
}


