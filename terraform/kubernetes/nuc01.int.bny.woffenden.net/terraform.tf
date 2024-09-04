terraform {
  backend "gcs" {
    bucket = "iac.woffenden.io"
    prefix = "kubernetes/nuc01.int.bny.woffenden.net"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}

provider "google" {
  project = "woffenden"
  region  = "europe-west2"
}

provider "kubernetes" {
  host            = "https://nuc01.tailnet-9b65.ts.net:6443"
  tls_server_name = "nuc01.int.bny.woffenden.net"

  client_certificate     = base64decode(data.google_secret_manager_secret_version.k8s_nuc01_client_certificate_data.secret_data)
  client_key             = base64decode(data.google_secret_manager_secret_version.k8s_nuc01_client_key_data.secret_data)
  cluster_ca_certificate = base64decode(data.google_secret_manager_secret_version.k8s_nuc01_certificate_authority_data.secret_data)
}