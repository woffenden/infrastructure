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

data "google_secret_manager_secret_version" "cloudflare_teams_tunnel_paperless_woffenden_family_id" {
  secret = "cloudflare-teams-tunnel-paperless-woffenden-family-id"
}

data "google_secret_manager_secret_version" "cloudflare_teams_tunnel_paperless_woffenden_family_secret" {
  secret = "cloudflare-teams-tunnel-paperless-woffenden-family-secret"
}

data "google_secret_manager_secret_version" "cloudflare_r2_paperless_woffenden_family_access_key_id" {
  secret = "cloudflare-r2-paperless-woffenden-family-access-key-id"
}

data "google_secret_manager_secret_version" "cloudflare_r2_paperless_woffenden_family_secret_access_key" {
  secret = "cloudflare-r2-paperless-woffenden-family-secret-access-key"
}

data "google_secret_manager_secret_version" "cloudflare_r2_paperless_woffenden_family_endpoint" {
  secret = "cloudflare-r2-paperless-woffenden-family-endpoint"
}

data "google_secret_manager_secret_version" "paperless_admin_password" {
  secret = "paperless-admin-password"
}

data "google_secret_manager_secret_version" "paperless_db_password" {
  secret = "paperless-db-password"
}

data "google_secret_manager_secret_version" "paperless_secret_key" {
  secret = "paperless-secret-key"
}
