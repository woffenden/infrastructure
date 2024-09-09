resource "google_secret_manager_secret" "bny_woffenden_net_tunnel_id" {
  secret_id = "cloudflare-teams-tunnel-bny-woffenden-net-id"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "bny_woffenden_net_tunnel_id" {
  secret = google_secret_manager_secret.bny_woffenden_net_tunnel_id.id

  secret_data = cloudflare_tunnel.bny_woffenden_net.id
}

resource "google_secret_manager_secret" "bny_woffenden_net_tunnel_secret" {
  secret_id = "cloudflare-teams-tunnel-bny-woffenden-net-secret"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "bny_woffenden_net_tunnel_secret" {
  secret = google_secret_manager_secret.bny_woffenden_net_tunnel_secret.id

  secret_data = base64encode(random_password.bny_woffenden_net_tunnel_secret.result)
}

resource "google_secret_manager_secret" "paperless_woffenden_family_tunnel_id" {
  secret_id = "cloudflare-teams-tunnel-paperless-woffenden-family-id"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "paperless_woffenden_family_tunnel_id" {
  secret = google_secret_manager_secret.paperless_woffenden_family_tunnel_id.id

  secret_data = cloudflare_tunnel.paperless_woffenden_family.id
}

resource "google_secret_manager_secret" "paperless_woffenden_family_tunnel_secret" {
  secret_id = "cloudflare-teams-tunnel-paperless-woffenden-family-secret"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "paperless_woffenden_family_tunnel_secret" {
  secret = google_secret_manager_secret.paperless_woffenden_family_tunnel_secret.id

  secret_data = base64encode(random_password.paperless_woffenden_family_tunnel_secret.result)
}
