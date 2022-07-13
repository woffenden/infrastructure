terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "mta-sts/"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.28"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.19"
    }
  }
}

provider "cloudflare" {}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}