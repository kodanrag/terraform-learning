# This code is to demo Launch of EC2 instance along with tags

provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "tf_lab4_instance" {
	instance_type = "t2.micro"
	ami = "ami-02e136e904f3da870"
	tags = {
		Name = "tf_lab4_instance"
		Environment = "Dev"
	}	
}
