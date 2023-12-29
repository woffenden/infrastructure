resource "cloudflare_access_policy" "paperless_woffenden_family" {
  account_id       = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  application_id   = cloudflare_access_application.paperless_woffenden_family.id
  name             = "allow"
  precedence       = "1"
  decision         = "allow"
  session_duration = "24h"

  include {
    group = [cloudflare_access_group.google_group_home.id]
  }
}

resource "cloudflare_access_policy" "unifi_woffenden_net" {
  account_id       = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  application_id   = cloudflare_access_application.unifi_woffenden_net.id
  name             = "allow"
  precedence       = "1"
  decision         = "allow"
  session_duration = "24h"

  include {
    group = [cloudflare_access_group.google_group_ddat_sre.id]
  }
}
