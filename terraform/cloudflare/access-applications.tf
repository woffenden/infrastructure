data "cloudflare_access_identity_provider" "google_workspace" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "woffenden.io"
}

data "cloudflare_access_identity_provider" "github" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "woffenden"
}

####

resource "cloudflare_access_application" "cloudflare_tunnel_demo_bny_woffenden_net" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "cloudflare-tunnel-demo.woffenden.net"
  domain     = "cloudflare-tunnel-demo.woffenden.net"
  type       = "self_hosted"
  allowed_idps = [
    data.cloudflare_access_identity_provider.github.id,
    data.cloudflare_access_identity_provider.google_workspace.id
  ]
}

####

resource "cloudflare_access_policy" "cloudflare_tunnel_demo_bny_woffenden_net_allow_sre" {
  account_id     = "af790e83102c7ab5347e7dfbf86ef021"
  application_id = cloudflare_access_application.cloudflare_tunnel_demo_bny_woffenden_net.id
  name           = "allow-sre"
  precedence     = 1
  decision       = "allow"
  include {
    gsuite {
      identity_provider_id = data.cloudflare_access_identity_provider.google_workspace.id
      email                = ["ddat.sre@woffenden.io"]
    }
  }
  require {
    device_posture = [
      cloudflare_device_posture_rule.warp.id,
      cloudflare_device_posture_rule.macos_version.id,
      cloudflare_device_posture_rule.macos_disk_encryption.id,
      cloudflare_device_posture_rule.macos_firewall.id
    ]
  }
}

resource "cloudflare_access_policy" "cloudflare_tunnel_demo_bny_woffenden_net_allow_gh_platform_and_security" {
  account_id     = "af790e83102c7ab5347e7dfbf86ef021"
  application_id = cloudflare_access_application.cloudflare_tunnel_demo_bny_woffenden_net.id
  name           = "allow-github-platform-and-security"
  precedence     = 2
  decision       = "allow"
  include {
    github {
      identity_provider_id = data.cloudflare_access_identity_provider.github.id
      name                 = "woffenden"
      teams                = ["Platform and Security"]
    }
  }
  require {
    device_posture = [
      cloudflare_device_posture_rule.warp.id,
      cloudflare_device_posture_rule.macos_version.id,
      cloudflare_device_posture_rule.macos_disk_encryption.id,
      cloudflare_device_posture_rule.macos_firewall.id
    ]
  }
}