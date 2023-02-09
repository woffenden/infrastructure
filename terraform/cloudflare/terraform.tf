terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "cloudflare/"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.34"
    }
  }
}

provider "cloudflare" {}