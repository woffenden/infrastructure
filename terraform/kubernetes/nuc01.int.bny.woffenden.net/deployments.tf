resource "kubernetes_deployment" "cloudflare_teams_doh_proxy" {
  metadata {
    name      = "doh-proxy"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
    labels = {
      app = "doh-proxy"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "doh-proxy"
      }
    }
    template {
      metadata {
        labels = {
          app = "doh-proxy"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
        }
        container {
          name  = "doh-proxy"
          image = "docker.io/cloudflare/cloudflared:2024.8.3"
          args = [
            "--no-autoupdate",
            "proxy-dns"
          ]
          env {
            name  = "TUNNEL_DNS_ADDRESS"
            value = "0.0.0.0"
          }
          env {
            name  = "TUNNEL_DNS_PORT"
            value = "53"
          }
          env {
            name  = "TUNNEL_DNS_UPSTREAM"
            value = "https://${data.google_secret_manager_secret_version.cloudflare_teams_doh_bny_woffenden_net.secret_data}/dns-query"
          }
          port {
            name           = "dns"
            container_port = 53
            protocol       = "UDP"
          }
          resources {
            limits = {
              cpu    = "100m"
              memory = "128Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }
          security_context {
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = true
            run_as_non_root            = true
            run_as_user                = 65532
          }
        }
      }
    }
  }
}
