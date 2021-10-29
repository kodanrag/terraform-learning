# This code is to demo Resource Addressing

provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "tf_lab5_instance" {
	instance_type = "t2.micro"
	ami = "ami-02e136e904f3da870"
}

resource "aws_ebs_volume" "tf_lab5_volume" {
	availability_zone = "us-east-1"
	size = 40
}

resource "aws_volume_attachment" "tf_lab5_attachment" {
	device_name = "/dev/sdh"
	volume_id = aws_ebs_volume.tf_lab5_volume.id
	instance_id = aws_instance.tf_lab5_instance.id
}
