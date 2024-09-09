resource "tls_private_key" "cloudflare_managed_network" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "cloudflare_managed_network" {
  private_key_pem = tls_private_key.cloudflare_managed_network.private_key_pem

  subject {
    common_name  = "managed-network.cloudflare.bny.woffenden.net"
    organization = "Woffenden"
  }

  dns_names             = ["managed-network.cloudflare.bny.woffenden.net"]
  validity_period_hours = 87600
  allowed_uses          = ["any_extended"]
}
