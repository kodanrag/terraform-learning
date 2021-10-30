# This code is to demo lanuch of an EC2 Linux instance

provider "aws" {
	region 	= "us-east-1"
	aws_access_key_id = var.aws_access_key_id
	aws_secret_access_key = var.aws_secret_access_key
}

resource "aws_instance" "tf_lab2_instance" {
	ami 		= "ami-02e136e904f3da870"
	instance_type 	= "t2.micro"
}


# The below code is used to enable remote execution. Currently we are using this code to run from Terraform cloud. 
# Ref URL: ---> https://www.terraform.io/docs/language/settings/backends/remote.html#basic-configuration

# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "devopsrk"

    workspaces {
      name = "terraform-learning"
    }
  }
}
