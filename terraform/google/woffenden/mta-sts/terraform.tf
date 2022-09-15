terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "mta-sts/"
  }
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

provider "cloudflare" {}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}