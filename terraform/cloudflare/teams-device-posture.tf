resource "cloudflare_device_posture_rule" "gateway" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  type       = "gateway"
  name       = "Gateway"
}

resource "cloudflare_device_posture_rule" "warp" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  type       = "warp"
  name       = "WARP"
}

resource "cloudflare_device_posture_rule" "macos_version" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
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
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
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
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
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
