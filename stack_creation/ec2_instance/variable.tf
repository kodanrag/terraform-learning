variable "instance_type" {}
variable "ami" {}
variable "Name" {}
variable "Environment" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {}
variable "user_datA" {}
variable "no_of_ec2" {
	default = 1
}
