resource "kubernetes_config_map" "cloudflare_teams_managed_network" {
  metadata {
    name      = "managed-network"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
  }
  data = {
    "default.conf" = file("${path.module}/src/cloudflare-teams/managed-network/default.conf")
  }
}

resource "kubernetes_config_map" "paperless_shared_library" {
  metadata {
    name      = "shared-library"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "shared-library.sh" = file("${path.module}/src/shared-library/shared-library.sh")
  }
}

resource "kubernetes_config_map" "paperless_backup" {
  metadata {
    name      = "paperless-backup"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "rclone.conf" = templatefile("${path.module}/src/paperless/paperless-backup/rclone.conf.tftpl", {
      access_key_id     = data.google_secret_manager_secret_version.cloudflare_r2_paperless_woffenden_family_access_key_id.secret_data
      secret_access_key = data.google_secret_manager_secret_version.cloudflare_r2_paperless_woffenden_family_secret_access_key.secret_data
      endpoint          = data.google_secret_manager_secret_version.cloudflare_r2_paperless_woffenden_family_endpoint.secret_data
    })
    "script.sh" = file("${path.module}/src/paperless/paperless-backup/script.sh")
  }
}

resource "kubernetes_config_map" "paperless_r2_cleanup" {
  metadata {
    name      = "r2-cleanup"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  data = {
    "script.sh" = file("${path.module}/src/paperless/r2-cleanup/script.sh")
  }
}
