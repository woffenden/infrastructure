locals {
  tenant_workspaces = {
    development = {
      name    = "development"
      account = "290514800660"
    }
    production = {
      name    = "production"
      account = "403623413395"
    }
  }
}

terraform {
  backend "s3" {
    bucket               = "woffenden-terraform"
    workspace_key_prefix = "cloud-platform-tenants/container-platform"
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
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${local.tenant_workspaces[terraform.workspace].account}:role/organisation-administrator-role"
  }
  default_tags {
    tags = {
      "business-unit" = "platforms"
      "application"   = "container-platform"
      "component"     = "main"
      "owner"         = "container-platform@woffenden.io"
      "source-code"   = "github.com/woffenden/infrastructure/terraform/aws/cloud-platform-tenants/container-platform"
      "environment"   = terraform.workspace
      "is-production" = terraform.workspace == "production" ? "true" : "false"
      "managed-by"    = "terraform"
    }
  }
}
