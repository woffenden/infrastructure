resource "kubernetes_deployment" "cloudflare_teams_doh_proxy" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

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
          run_as_non_root     = true
          supplemental_groups = []
        }
        container {
          name              = "doh-proxy"
          image             = "docker.io/cloudflare/cloudflared:2024.8.3"
          image_pull_policy = "Always"
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
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = true
            run_as_non_root            = true
            run_as_user                = 65532
            run_as_group               = 65532
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "cloudflare_teams_warp_tunnel" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "warp-tunnel"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
    labels = {
      app = "warp-tunnel"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "warp-tunnel"
      }
    }
    template {
      metadata {
        labels = {
          app = "warp-tunnel"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
          run_as_non_root     = true
          supplemental_groups = []
        }
        container {
          name              = "warp-tunnel"
          image             = "docker.io/cloudflare/cloudflared:2024.8.3"
          image_pull_policy = "Always"
          args = [
            "--no-autoupdate",
            "tunnel",
            "run"
          ]
          env {
            name = "TUNNEL_TOKEN"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.cloudflare_teams_warp_tunnel.metadata[0].name
                key  = "tunnel-token"
              }
            }
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
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = true
            run_as_non_root            = true
            run_as_user                = 65532
            run_as_group               = 65532
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "cloudflare_teams_managed_network" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "managed-network"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
    labels = {
      app = "managed-network"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "managed-network"
      }
    }
    template {
      metadata {
        labels = {
          app = "managed-network"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
          run_as_non_root     = true
          supplemental_groups = []
        }
        container {
          name              = "nginx"
          image             = "docker.io/nginxinc/nginx-unprivileged:1.26.2-alpine3.20"
          image_pull_policy = "Always"
          port {
            name           = "https"
            container_port = 443
            protocol       = "TCP"
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
          volume_mount {
            name       = "nginx-config"
            mount_path = "/etc/nginx/conf.d/default.conf"
            sub_path   = "default.conf"
          }
          volume_mount {
            name       = "tls-key"
            mount_path = "/etc/nginx/tls.key"
            sub_path   = "tls.key"
          }
          volume_mount {
            name       = "tls-pem"
            mount_path = "/etc/nginx/tls.pem"
            sub_path   = "tls.pem"
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = true
            run_as_user                = 101
            run_as_group               = 101
          }
        }
        volume {
          name = "nginx-config"
          config_map {
            name = kubernetes_config_map.cloudflare_teams_managed_network.metadata[0].name
            items {
              key  = "default.conf"
              path = "default.conf"
            }
          }
        }
        volume {
          name = "tls-key"
          secret {
            secret_name = kubernetes_secret.cloudflare_teams_managed_network.metadata[0].name
            items {
              key  = "tls.key"
              path = "tls.key"
            }
          }
        }
        volume {
          name = "tls-pem"
          secret {
            secret_name = kubernetes_secret.cloudflare_teams_managed_network.metadata[0].name
            items {
              key  = "tls.pem"
              path = "tls.pem"
            }
          }
        }
      }
    }
  }
}
