locals {
    aws_region= "us-east-1"
     project_name = "my-app"
  }

# This section has inconsistent indentation compared to the locals block
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "terragrunt-state-${local.project_name}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "terragrunt-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}
