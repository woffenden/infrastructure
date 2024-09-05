resource "cloudflare_teams_account" "woffenden" {
  account_id           = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  tls_decrypt_enabled  = false
  activity_log_enabled = true

  block_page {
    enabled = false
  }

  fips {
    tls = false
  }

  antivirus {
    enabled_download_phase = true
    enabled_upload_phase   = true
    fail_closed            = true
  }

  proxy {
    tcp        = true
    udp        = true
    root_ca    = false
    virtual_ip = false
  }

  ssh_session_log {
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBW3ifjrwEykLtSbEvXWULacMK2Tv1mP6cOLm2lsrVai"
  }

  extended_email_matching {
    enabled = true
  }

  logging {
    redact_pii = false
    settings_by_rule_type {
      dns {
        log_all    = true
        log_blocks = false
      }
      http {
        log_all    = true
        log_blocks = false
      }
      l4 {
        log_all    = true
        log_blocks = false
      }
    }
  }
}
