#variable "region" {
#	type = string
#}

variable "instance_type" {
	type = string
#	default = "t2.micro"
}

variable "image_id" {
	type = string
#	default = "ami-02e136e904f3da870"
}

variable "tag_name" {
	type = string
}

variable "tag_env" {
	type = string
}
	
