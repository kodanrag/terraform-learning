# This code is to demo lanuch of an EC2 Linux instance

provider "aws" {
	region 	= "us-east-1"
}

resource "aws_instance" "tf_lab2_instance" {
	ami 		= "ami-02e136e904f3da870"
	instance_type 	= "t2.micro"
}
