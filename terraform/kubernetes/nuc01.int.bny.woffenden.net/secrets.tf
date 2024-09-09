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
