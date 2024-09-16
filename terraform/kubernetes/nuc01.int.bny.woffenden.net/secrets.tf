resource "kubernetes_secret" "cloudflare_teams_warp_tunnel" {
  metadata {
    name      = "warp-tunnel"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
  }
  type = "Opaque"
  data = {
    "tunnel-token" = base64encode(
      jsonencode({
        "a" = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
        "t" = data.google_secret_manager_secret_version.cloudflare_teams_tunnel_bny_woffenden_net_id.secret_data
        "s" = data.google_secret_manager_secret_version.cloudflare_teams_tunnel_bny_woffenden_net_secret.secret_data
      })
    )
  }
}

resource "kubernetes_secret" "paperless_warp_tunnel" {
  metadata {
    name      = "warp-tunnel"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  type = "Opaque"
  data = {
    "tunnel-token" = base64encode(
      jsonencode({
        "a" = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
        "t" = data.google_secret_manager_secret_version.cloudflare_teams_tunnel_paperless_woffenden_family_id.secret_data
        "s" = data.google_secret_manager_secret_version.cloudflare_teams_tunnel_paperless_woffenden_family_secret.secret_data
      })
    )
  }
}

resource "kubernetes_secret" "cloudflare_teams_managed_network" {
  metadata {
    name      = "managed-network"
    namespace = kubernetes_namespace.cloudflare_teams.metadata[0].name
  }
  type = "Opaque"
  data = {
    "tls.key" = tls_private_key.cloudflare_managed_network.private_key_pem
    "tls.pem" = tls_self_signed_cert.cloudflare_managed_network.cert_pem
  }
}
