data "google_secret_manager_secret_version" "k8s_nuc01_certificate_authority_data" {
  secret = "k8s-nuc01-certificate-authority-data"
}

data "google_secret_manager_secret_version" "k8s_nuc01_client_certificate_data" {
  secret = "k8s-nuc01-client-certificate-data"
}

data "google_secret_manager_secret_version" "k8s_nuc01_client_key_data" {
  secret = "k8s-nuc01-client-key-data"
}

data "google_secret_manager_secret_version" "cloudflare_account_id" {
  secret = "cloudflare-account-id"
}

data "google_secret_manager_secret_version" "cloudflare_teams_doh_bny_woffenden_net" {
  secret = "cloudflare-teams-doh-bny-woffenden-net"
}

data "google_secret_manager_secret_version" "cloudflare_teams_tunnel_bny_woffenden_net_id" {
  secret = "cloudflare-teams-tunnel-bny-woffenden-net-id"
}

data "google_secret_manager_secret_version" "cloudflare_teams_tunnel_bny_woffenden_net_secret" {
  secret = "cloudflare-teams-tunnel-bny-woffenden-net-secret"
}
