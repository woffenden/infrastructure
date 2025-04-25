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
          image             = "docker.io/cloudflare/cloudflared:2025.4.0"
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
          image             = "docker.io/nginxinc/nginx-unprivileged:1.28.0-alpine3.21-slim"
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

resource "kubernetes_deployment" "homebridge" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "homebridge"
    namespace = kubernetes_namespace.homebridge.metadata[0].name
    labels = {
      app = "homebridge"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "homebridge"
      }
    }
    template {
      metadata {
        labels = {
          app = "homebridge"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
          run_as_non_root     = false
          supplemental_groups = []
        }
        host_network = true
        container {
          name              = "homebridge"
          image             = "ghcr.io/homebridge/homebridge:2025-02-26"
          image_pull_policy = "Always"
          env {
            name  = "TZ"
            value = "Europe/London"
          }
          env {
            name  = "ENABLE_AVAHI"
            value = "1"
          }
          port {
            name           = "homebridge"
            container_port = 8581
            host_port      = 8581
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "4Gi"
            }
            requests = {
              cpu    = "100m"
              memory = "2Gi"
            }
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = false
            run_as_user                = 0
            run_as_group               = 0
          }
          volume_mount {
            name       = "homebridge-data"
            mount_path = "/homebridge"
          }
        }
        volume {
          name = "homebridge-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.homebridge.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "paperless_redis" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "redis"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app = "redis"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "redis"
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = {
          app = "redis"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
          run_as_non_root     = false
          supplemental_groups = []
        }
        container {
          name              = "redis"
          image             = "docker.io/redis:7.4.1-alpine3.20"
          image_pull_policy = "Always"
          port {
            name           = "redis"
            container_port = 6379
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "500Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = false
            run_as_user                = 0
            run_as_group               = 0
          }
          volume_mount {
            name       = "redis-data"
            mount_path = "/data"
          }
        }
        volume {
          name = "redis-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless_redis.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "paperless_postgres" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app = "postgres"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "postgres"
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
          run_as_non_root     = false
          supplemental_groups = []
        }
        container {
          name              = "postgres"
          image             = "docker.io/postgres:15.8-alpine3.20"
          image_pull_policy = "Always"
          env {
            name  = "POSTGRES_USER"
            value = "paperless"
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = data.google_secret_manager_secret_version.paperless_db_password.secret_data
          }
          env {
            name  = "POSTGRES_DB"
            value = "paperless"
          }
          port {
            name           = "postgres"
            container_port = 5432
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "500Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = false
            run_as_user                = 0
            run_as_group               = 0
          }
          volume_mount {
            name       = "postgres-data"
            mount_path = "/var/lib/postgresql/data"
          }
        }
        volume {
          name = "postgres-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless_postgres.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "paperless" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "paperless"
    namespace = kubernetes_namespace.paperless.metadata[0].name
    labels = {
      app = "paperless"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "paperless"
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = {
          app = "paperless"
        }
      }
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
        }
        container {
          name              = "paperless"
          image             = "ghcr.io/paperless-ngx/paperless-ngx:2.13.5"
          image_pull_policy = "Always"
          env {
            name  = "USERMAP_UID"
            value = "1000"
          }
          env {
            name  = "USERMAP_GID"
            value = "1000"
          }
          env {
            name  = "PAPERLESS_REDIS"
            value = "redis://redis.paperless.svc.cluster.local:6379"
          }
          env {
            name  = "PAPERLESS_DBHOST"
            value = "postgres.paperless.svc.cluster.local"
          }
          env {
            name  = "PAPERLESS_DBPORT"
            value = "5432"
          }
          env {
            name  = "PAPERLESS_DBUSER"
            value = "paperless"
          }
          env {
            name  = "PAPERLESS_DBPASS"
            value = data.google_secret_manager_secret_version.paperless_db_password.secret_data
          }
          env {
            name  = "PAPERLESS_DBNAME"
            value = "paperless"
          }
          env {
            name  = "PAPERLESS_PORT"
            value = "8000"
          }
          env {
            name  = "PAPERLESS_TIMEZONE"
            value = "Europe/London"
          }
          env {
            name  = "PAPERLESS_SECRET_KEY"
            value = data.google_secret_manager_secret_version.paperless_secret_key.secret_data
          }
          env {
            name  = "PAPERLESS_URL"
            value = "https://paperless.woffenden.family"
          }
          env {
            name  = "PAPERLESS_ADMIN_USER"
            value = "jacob@woffenden.io"
          }
          env {
            name  = "PAPERLESS_ADMIN_PASSWORD"
            value = data.google_secret_manager_secret_version.paperless_admin_password.secret_data
          }
          env {
            name  = "PAPERLESS_ADMIN_EMAIL"
            value = "jacob@woffenden.io"
          }
          env {
            name  = "PAPERLESS_ENABLE_HTTP_REMOTE_USER"
            value = "true"
          }
          env {
            name  = "PAPERLESS_HTTP_REMOTE_USER_HEADER_NAME"
            value = "HTTP_CF_ACCESS_AUTHENTICATED_USER_EMAIL"
          }
          env {
            name  = "PAPERLESS_LOGOUT_REDIRECT_URL"
            value = "https://woffenden.cloudflareaccess.com/cdn-cgi/access/logout"
          }
          env {
            name  = "PAPERLESS_OCR_LANGUAGE"
            value = "eng"
          }
          env {
            name  = "PAPERLESS_TIKA_ENABLED"
            value = "1"
          }
          env {
            name  = "PAPERLESS_TIKA_GOTENBERG_ENDPOINT"
            value = "http://gotenberg:3000"
          }
          env {
            name  = "PAPERLESS_TIKA_ENDPOINT"
            value = "http://tika:9998"
          }
          env {
            name  = "PAPERLESS_APP_TITLE"
            value = "Woffenden Paperless"
          }
          port {
            name           = "paperless"
            container_port = 8000
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "500m"
              memory = "4Gi"
            }
            requests = {
              cpu    = "250m"
              memory = "2Gi"
            }
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = false
            run_as_user                = 0
            run_as_group               = 0
          }
          volume_mount {
            name       = "paperless-consume"
            mount_path = "/usr/src/paperless/consume"
          }
          volume_mount {
            name       = "paperless-data"
            mount_path = "/usr/src/paperless/data"
          }
          volume_mount {
            name       = "paperless-export"
            mount_path = "/usr/src/paperless/export"
          }
          volume_mount {
            name       = "paperless-media"
            mount_path = "/usr/src/paperless/media"
          }
        }
        container {
          name              = "gotenberg"
          image             = "docker.io/gotenberg/gotenberg:8.14.1"
          image_pull_policy = "Always"
          command           = ["gotenberg"]
          args = [
            "--chromium-disable-javascript=true",
            "--chromium-allow-list=file:///tmp/.*"
          ]
          port {
            name           = "gotenberg"
            container_port = 3000
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "500Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = true
            run_as_user                = 1001
            run_as_group               = 1001
          }
        }
        container {
          name              = "tika"
          image             = "docker.io/apache/tika:3.0.0.0"
          image_pull_policy = "Always"
          port {
            name           = "tika"
            container_port = 9998
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "500Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "256Mi"
            }
          }
          security_context {
            seccomp_profile {
              type = "RuntimeDefault"
            }
            allow_privilege_escalation = false
            privileged                 = false
            read_only_root_filesystem  = false
            run_as_non_root            = true
            run_as_user                = 35002
            run_as_group               = 35002
          }
        }
        volume {
          name = "paperless-consume"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless_consume.metadata[0].name
          }
        }
        volume {
          name = "paperless-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless_data.metadata[0].name
          }
        }
        volume {
          name = "paperless-export"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless_export.metadata[0].name
          }
        }
        volume {
          name = "paperless-media"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.paperless_media.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "paperless_warp_tunnel" {
  #ts:skip=AC_K8S_0064 I cannot figure out what combination of settings will make this work

  metadata {
    name      = "warp-tunnel"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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
          image             = "docker.io/cloudflare/cloudflared:2025.4.0"
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
                name = kubernetes_secret.paperless_warp_tunnel.metadata[0].name
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
