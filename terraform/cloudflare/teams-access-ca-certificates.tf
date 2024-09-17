resource "cloudflare_access_ca_certificate" "ssh" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data

  application_id = cloudflare_access_application.ssh_woffenden_net.id
}
