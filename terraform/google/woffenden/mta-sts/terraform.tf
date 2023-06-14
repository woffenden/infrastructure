terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "mta-sts/"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.8.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.69.1"
    }
  }
}

provider "cloudflare" {}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}
