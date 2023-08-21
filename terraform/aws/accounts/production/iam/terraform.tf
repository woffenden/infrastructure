terraform {
  backend "s3" {
    bucket         = "woffenden-terraform"
    key            = "production/iam/terraform.tfstate"
    dynamodb_table = "terraform"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:eu-west-2:749019155605:key/e68a6c13-c02f-4bc2-bf92-03b0edf55b4d"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::655105654343:role/organisation-administrator-role"
  }
  default_tags {
    tags = {
      "business-unit" = "platforms"
      "application"   = "infrastructure"
      "component"     = "iam"
      "owner"         = "ddat.aws@woffenden.io"
      "source-code"   = "github.com/woffenden/infrastructure/terraform/aws/accounts/production/iam"
      "environment"   = "management"
      "is-production" = "true"
      "managed-by"    = "terraform"
    }
  }
}
