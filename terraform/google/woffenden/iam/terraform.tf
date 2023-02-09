terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "iam/"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.53"
    }
  }
}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}