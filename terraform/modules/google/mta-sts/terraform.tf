terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.36"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.23"
    }
  }
}