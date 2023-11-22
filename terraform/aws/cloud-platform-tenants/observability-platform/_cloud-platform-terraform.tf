/*
  This file is managed by @woffenden/cloud-platform
  Any changes will be overwritten
*/

terraform {
  backend "s3" {
    bucket               = "woffenden-terraform"
    workspace_key_prefix = "cloud-platform-tenants/observability-platform"
    key                  = "terraform.tfstate"
    dynamodb_table       = "terraform"
    encrypt              = true
    kms_key_id           = "arn:aws:kms:eu-west-2:749019155605:key/e68a6c13-c02f-4bc2-bf92-03b0edf55b4d"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

provider "aws" {
  alias = "session"
}

data "aws_organizations_organization" "org" {
  provider = aws.session
}

data "aws_organizations_organizational_unit" "ou" {
  provider = aws.session

  parent_id = data.aws_organizations_organization.org.roots[0].id
  name      = "cloud-platform-tenants"
}

data "aws_organizations_organizational_unit_child_accounts" "accounts" {
  provider = aws.session

  parent_id = data.aws_organizations_organizational_unit.ou.id
}

locals {
  cloud_platform_account = [for account in data.aws_organizations_organizational_unit_child_accounts.accounts.accounts : account if account.name == terraform.workspace]
}

provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${local.cloud_platform_account.id}:role/organisation-administrator-role"
  }
  default_tags {
    tags = {
      "business-unit" = "platforms"
      "application"   = "observability-platform"
      "component"     = "main"
      "owner"         = "observability-platform@woffenden.io"
      "source-code"   = "github.com/woffenden/infrastructure/terraform/aws/cloud-platform-tenants/observability-platform"
      "environment"   = terraform.workspace
      "is-production" = endswith(terraform.workspace, "-production") ? "true" : "false"
      "managed-by"    = "terraform"
    }
  }
}
