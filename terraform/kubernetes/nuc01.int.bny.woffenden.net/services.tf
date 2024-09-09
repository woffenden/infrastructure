resource "kubernetes_service" "cloudflare_teams_doh_proxy" {
  metadata {
    name      = "doh-proxy"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
    annotations = {
      "metallb.universe.tf/ip-allocated-from-pool" = "bny-woffenden-net"
    }
    labels = {
      app = "doh-proxy"
    }
  }
  spec {
    selector = {
      app = "doh-proxy"
    }
    type             = "LoadBalancer"
    load_balancer_ip = "10.100.0.53"
    port {
      name        = "dns"
      port        = 53
      target_port = 53
      protocol    = "UDP"
    }
  }
}

resource "kubernetes_service" "cloudflare_teams_managed_network" {
  metadata {
    name      = "managed-network"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
    annotations = {
      "metallb.universe.tf/ip-allocated-from-pool" = "bny-woffenden-net"
    }
    labels = {
      app = "managed-network"
    }
  }
  spec {
    selector = {
      app = "managed-network"
    }
    type             = "LoadBalancer"
    load_balancer_ip = "10.100.0.52"
    port {
      name        = "https"
      port        = 443
      target_port = 443
      protocol    = "TCP"
    }
  }
}

import {
  to = kubernetes_service.cloudflare_teams_managed_network
  id = "cloudflare-teams/managed-network"
}
