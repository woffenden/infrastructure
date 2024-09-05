resource "kubernetes_namespace" "metallb_system" {
  metadata {
    name = "metallb-system"
    labels = {
      name = "metallb-system"
    }
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
    labels = {
      name = "cert-manager"
    }
  }
}

resource "kubernetes_namespace" "cloudflare_teams" {
  metadata {
    name = "cloudflare-teams"
    labels = {
      name = "cloudflare-teams"
    }
  }
}

resource "kubernetes_namespace" "paperless" {
  metadata {
    name = "paperless"
    labels = {
      name = "paperless"
    }
  }
}

resource "kubernetes_namespace" "homebridge" {
  metadata {
    name = "homebridge"
    labels = {
      name = "homebridge"
    }
  }
}
