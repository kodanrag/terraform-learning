locals {
    aws_region = "us-east-1"
    # The following line uses a highly non-standard, very large amount of indentation
        project_name = "my-app"
  }

# This section is indented using spaces, but the opening bracket for 'remote_state' is on its own line, which is non-standard HCL
remote_state
{
  backend = "s3"
  config = {
    encrypt        = true
    bucket = "terragrunt-state-${local.project_name}"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = local.aws_region
    dynamodb_table = "terragrunt-locks"
  }
}
