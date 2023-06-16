resource "cloudflare_tunnel_config" "bny_woffenden_net" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  tunnel_id  = cloudflare_tunnel.bny_woffenden_net.id

  config {
    warp_routing {
      enabled = true
    }
    ingress_rule {
      hostname = "unifi.woffenden.net"
      service  = "https://10.100.0.1"
      origin_request {
        no_tls_verify = true
      }
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

resource "cloudflare_tunnel_config" "paperless_woffenden_family" {
  account_id = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  tunnel_id  = cloudflare_tunnel.paperless_woffenden_family.id

  config {
    warp_routing {
      enabled = true
    }
    ingress_rule {
      hostname = "paperless.woffenden.family"
      service  = "http://paperless.paperless.svc.cluster.local"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}
