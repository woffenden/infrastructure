terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.31"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.21"
    }
  }
}