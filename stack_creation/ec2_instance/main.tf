# This code is to demo Launch of EC2 instance along with tags

resource "aws_instance" "raghu_ec2_instance" {
        instance_type = var.instance_type
        ami = var.ami
        subnet_id = var.subnet_id
        tags = {
    		Name = var.Name
    		Environment = var.Environment
 	}

}

