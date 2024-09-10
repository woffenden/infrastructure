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
