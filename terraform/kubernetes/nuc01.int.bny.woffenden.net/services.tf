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

resource "kubernetes_service" "paperless_redis" {
  metadata {
    name      = "redis"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app = "redis"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "redis"
    }
    port {
      name        = "redis"
      port        = 6379
      target_port = "redis"
      protocol    = "TCP"
    }
  }
}

resource "kubernetes_service" "paperless_postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app = "postgres"
    }
  }
  spec {
    type = "ClusterIP"
    selector = {
      app = "postgres"
    }
    port {
      name        = "postgres"
      port        = 5432
      target_port = "postgres"
      protocol    = "TCP"
    }
  }
}
