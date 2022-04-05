locals {
  globals            = read_terragrunt_config(find_in_parent_folders("globals.hcl"))
  user_id            = split(":", get_aws_caller_identity_user_id())[0]
  session_identifier = tobool(get_env("GITHUB_ACTIONS", false)) == true ? get_env("GITHUB_RUN_ID") : "LOCAL"
  session_name       = "TERRAFORM_${local.user_id}_${local.session_identifier}"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "terraform-backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "${local.globals.inputs.woffenden_terraform_config.s3_bucket}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.globals.inputs.woffenden_aws_region}"
    encrypt        = true
    kms_key_id     = "${local.globals.inputs.woffenden_terraform_config.kms_key_id}"
    dynamodb_table = "${local.globals.inputs.woffenden_terraform_config.dynamodb_table}"
    session_name   = local.session_name
  }
}

generate "provider" {
  path      = "terraform-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4.0"
    }
  }
}

variable woffenden_aws_iam_roles {
  type = map(string)
}

provider "aws" {
  region = "${local.globals.inputs.woffenden_aws_region}"
  assume_role {
    role_arn     = var.woffenden_aws_iam_roles["${split("/", path_relative_to_include())[0]}"]
    session_name = "${local.session_name}"
  }
}
EOF
}

generate "global_variables" {
  path      = "terraform-global-variables.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
EOF
}


# --- Configure terraform execution
terraform {
  extra_arguments "common_vars" {
    commands = [
      "destroy",
      "plan",
      "apply"
    ]

    arguments = [
      #"-var-file=${get_parent_terragrunt_dir()}/global.tfvars",
    ]
  }
}


inputs = merge(
  local.globals.inputs
)