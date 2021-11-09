# This code is to demo Launch of EC2 instance along with tags

resource "aws_instance" "raghu_ec2_instance" {
	count     = var.no_of_ec2
        subnet_id = "${element(var.subnet_id, count.index)}"
        instance_type = var.instance_type
        ami = var.ami
        tags = {
                Name = "${element(var.Name, count.index)}"
    		Environment = var.Environment
 	}
        vpc_security_group_ids = [ var.vpc_security_group_ids ]
        user_data = var.user_datA
}

