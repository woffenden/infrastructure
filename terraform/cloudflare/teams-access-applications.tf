resource "cloudflare_access_application" "paperless_woffenden_family" {
  account_id                = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name                      = "Paperless"
  domain                    = "paperless.woffenden.family"
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = true
  logo_url                  = "https://cdn.woffenden.io/zero-trust-assets/paperless-ngx.jpeg"
  allowed_idps              = [data.cloudflare_zero_trust_access_identity_provider.google_workspace.id]
}

resource "cloudflare_access_application" "unifi_woffenden_net" {
  account_id                 = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name                       = "UniFi"
  domain                     = "unifi.woffenden.net"
  type                       = "self_hosted"
  session_duration           = "24h"
  auto_redirect_to_identity  = true
  logo_url                   = "https://cdn.woffenden.io/zero-trust-assets/ubiquiti.png"
  http_only_cookie_attribute = true
  allowed_idps               = [data.cloudflare_zero_trust_access_identity_provider.google_workspace.id]
}
