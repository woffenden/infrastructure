terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "mta-sts/"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.24"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.16"
    }
  }
}

provider "cloudflare" {}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}