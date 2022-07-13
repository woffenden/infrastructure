resource "cloudflare_device_posture_rule" "gateway" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  type       = "gateway"
  name       = "Gateway"
}

resource "cloudflare_device_posture_rule" "warp" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  type       = "warp"
  name       = "WARP"
}

resource "cloudflare_device_posture_rule" "macos_version" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  type       = "os_version"
  name       = "macOS Version"
  schedule   = "5m"
  expiration = "30m"
  match {
    platform = "mac"
  }
  input {
    operator = ">="
    version  = "12.4.0"
  }
}

resource "cloudflare_device_posture_rule" "macos_disk_encryption" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  type       = "disk_encryption"
  name       = "macOS Disk Encryption"
  schedule   = "5m"
  expiration = "30m"
  match {
    platform = "mac"
  }
  input {
    require_all = true
  }
}

resource "cloudflare_device_posture_rule" "macos_firewall" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  type       = "firewall"
  name       = "macOS Firewall"
  schedule   = "5m"
  expiration = "30m"
  match {
    platform = "mac"
  }
  input {
    enabled = true
  }
}