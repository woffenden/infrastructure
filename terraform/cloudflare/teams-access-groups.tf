resource "cloudflare_access_group" "google_group_ddat_sre" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "DDaT SRE"

  include {
    gsuite {
      identity_provider_id = data.cloudflare_zero_trust_access_identity_provider.google_workspace.id
      email                = ["ddat.sre@woffenden.io"]
    }
  }
}

resource "cloudflare_access_group" "google_group_home" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  name       = "Woffenden Family"

  include {
    gsuite {
      identity_provider_id = data.cloudflare_zero_trust_access_identity_provider.google_workspace.id
      email                = ["home@woffenden.io"]
    }
  }
}
