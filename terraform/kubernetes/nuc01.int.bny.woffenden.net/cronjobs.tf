# resource "kubernetes_cron_job_v1" "paperless_backup" {
#   metadata {
#     name      = "paperless-backup"
#     namespace = kubernetes_namespace.paperless.metadata[0].name
#   }
#   spec {
#     schedule                      = "0 0 * * *"
#     successful_jobs_history_limit = 3
#     job_template {
#       metadata {
#         annotations = {}
#       }
#       spec {
#         completions                = "1"
#         ttl_seconds_after_finished = "86400"
#         template {
#           metadata {
#             annotations = {}
#           }
#           spec {
#             restart_policy       = "Never"
#             service_account_name = kubernetes_service_account.paperless_backup.metadata[0].name
#             container {
#               name    = "paperless-backup"
#               image   = "docker.io/alpine:3.19"
#               command = ["/bin/sh", "-c", "/config/script.sh"]
#               env {
#                 name = "KUBERNETES_NAMESPACE"
#                 value_from {
#                   field_ref {
#                     field_path = "metadata.namespace"
#                   }
#                 }
#               }
#               env {
#                 name  = "RCLONE_CONFIG"
#                 value = "/config/rclone.conf"
#               }
#               env {
#                 name  = "RCLONE_FS"
#                 value = "cloudflare:paperless-woffenden-family"
#               }
#               volume_mount {
#                 name       = "config"
#                 mount_path = "/config"
#               }
#               volume_mount {
#                 name       = "paperless-consume"
#                 mount_path = "/usr/src/paperless/consume"
#               }
#               volume_mount {
#                 name       = "paperless-data"
#                 mount_path = "/usr/src/paperless/data"
#               }
#               volume_mount {
#                 name       = "paperless-export"
#                 mount_path = "/usr/src/paperless/export"
#               }
#               volume_mount {
#                 name       = "paperless-media"
#                 mount_path = "/usr/src/paperless/media"
#               }
#               volume_mount {
#                 name       = "postgres-data"
#                 mount_path = "/var/lib/postgresql/data"
#               }
#             }
#             volume {
#               name = "config"
#               config_map {
#                 name = kubernetes_config_map.paperless_backup.metadata[0].name
#                 items {
#                   key  = "rclone.conf"
#                   path = "rclone.conf"
#                 }
#                 items {
#                   key  = "script.sh"
#                   path = "script.sh"
#                   mode = "0777"
#                 }
#               }
#             }
#             volume {
#               name = "paperless-consume"
#               persistent_volume_claim {
#                 claim_name = kubernetes_persistent_volume_claim.paperless_consume.metadata[0].name
#               }
#             }
#             volume {
#               name = "paperless-data"
#               persistent_volume_claim {
#                 claim_name = kubernetes_persistent_volume_claim.paperless_data.metadata[0].name
#               }
#             }
#             volume {
#               name = "paperless-export"
#               persistent_volume_claim {
#                 claim_name = kubernetes_persistent_volume_claim.paperless_export.metadata[0].name
#               }
#             }
#             volume {
#               name = "paperless-media"
#               persistent_volume_claim {
#                 claim_name = kubernetes_persistent_volume_claim.paperless_media.metadata[0].name
#               }
#             }
#             volume {
#               name = "postgres-data"
#               persistent_volume_claim {
#                 claim_name = kubernetes_persistent_volume_claim.paperless_postgres.metadata[0].name
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_cron_job_v1" "paperless_r2_cleanup" {
#   metadata {
#     name      = "r2-cleanup"
#     namespace = kubernetes_namespace.paperless.metadata[0].name
#   }
#   spec {
#     schedule                      = "0 2 * * *"
#     successful_jobs_history_limit = 3
#     job_template {
#       metadata {
#         annotations = {}
#       }
#       spec {
#         completions                = "1"
#         ttl_seconds_after_finished = "86400"
#         template {
#           metadata {
#             annotations = {}
#           }
#           spec {
#             restart_policy = "Never"
#             container {
#               name    = "r2-cleanup"
#               image   = "docker.io/amazon/aws-cli:latest"
#               command = ["/bin/bash", "-c", "/config/script.sh"]
#               env {
#                 name  = "AWS_ACCESS_KEY_ID"
#                 value = data.google_secret_manager_secret_version.cloudflare_r2_paperless_woffenden_family_access_key_id.secret_data
#               }
#               env {
#                 name  = "AWS_SECRET_ACCESS_KEY"
#                 value = data.google_secret_manager_secret_version.cloudflare_r2_paperless_woffenden_family_secret_access_key.secret_data
#               }
#               env {
#                 name  = "AWS_ENDPOINT_URL"
#                 value = data.google_secret_manager_secret_version.cloudflare_r2_paperless_woffenden_family_endpoint.secret_data
#               }
#               env {
#                 name  = "CLOUDFLARE_R2_BUCKET"
#                 value = "paperless-woffenden-family"
#               }
#               volume_mount {
#                 name       = "config"
#                 mount_path = "/config"
#               }
#             }
#             volume {
#               name = "config"
#               config_map {
#                 name = kubernetes_config_map.paperless_r2_cleanup.metadata[0].name
#                 items {
#                   key  = "script.sh"
#                   path = "script.sh"
#                   mode = "0777"
#                 }
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }
