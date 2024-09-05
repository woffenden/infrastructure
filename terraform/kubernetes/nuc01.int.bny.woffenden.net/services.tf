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

import {
  to = kubernetes_service.cloudflare_teams_doh_proxy
  id = "cloudflare-teams/doh-proxy"
}
