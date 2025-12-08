terraform {
  backend "s3" {
    bucket         = "woffenden-terraform"
    key            = "root/organisation/terraform.tfstate"
    dynamodb_table = "terraform"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:eu-west-2:749019155605:key/e68a6c13-c02f-4bc2-bf92-03b0edf55b4d"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.9.0"
    }
  }
  required_version = "~> 1.5"
}

provider "aws" {
  alias = "session"
}

provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = can(regex("root", data.aws_iam_session_context.session.issuer_arn)) ? null : "arn:aws:iam::749019155605:role/github-actions"
  }
  default_tags {
    tags = {
      "business-unit" = "platforms"
      "application"   = "infrastructure"
      "component"     = "organisation"
      "owner"         = "aws@woffenden.io"
      "source-code"   = "github.com/woffenden/infrastructure/terraform/aws/root/organisation"
      "environment"   = "management"
      "is-production" = "true"
      "managed-by"    = "terraform"
    }
  }
}

provider "github" {
  owner = "woffenden"
  token = data.aws_secretsmanager_secret_version.github_token.secret_string
}
