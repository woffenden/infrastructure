terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "cloudflare/"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.43.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  required_version = "~> 1.5"
}

provider "cloudflare" {
  email   = data.google_secret_manager_secret_version.cloudflare_email.secret_data
  api_key = data.google_secret_manager_secret_version.cloudflare_api_key.secret_data
}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}
