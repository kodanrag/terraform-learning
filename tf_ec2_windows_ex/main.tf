# This code is to demo Launch of an Windows EC2 instance

provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "tf_lab3_windows_instance" {
	instance_type 	= "t2.micro"
	ami		= "ami-0416f96ae3d1a3f29"
}
