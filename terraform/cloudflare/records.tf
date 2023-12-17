resource "cloudflare_record" "woffenden_cloud_aws_ns1" {
  zone_id = module.woffenden_cloud_cloudflare_zone.id
  name    = "aws"
  type    = "NS"
  value   = "ns-1682.awsdns-18.co.uk"
}

resource "cloudflare_record" "woffenden_cloud_aws_ns2" {
  zone_id = module.woffenden_cloud_cloudflare_zone.id
  name    = "aws"
  type    = "NS"
  value   = "ns-630.awsdns-14.net"
}

resource "cloudflare_record" "woffenden_cloud_aws_ns3" {
  zone_id = module.woffenden_cloud_cloudflare_zone.id
  name    = "aws"
  type    = "NS"
  value   = "ns-321.awsdns-40.com"
}

resource "cloudflare_record" "woffenden_cloud_aws_ns4" {
  zone_id = module.woffenden_cloud_cloudflare_zone.id
  name    = "aws"
  type    = "NS"
  value   = "ns-1286.awsdns-32.org"
}

resource "cloudflare_record" "woffenden_dev_github_pages_challenge" {
  zone_id = module.woffenden_dev_cloudflare_zone.id
  name    = "_github-pages-challenge-woffenden"
  type    = "TXT"
  value   = "3ff9951c0a51b83dca75b05f205366"
}

resource "cloudflare_record" "woffenden_family_paperless_cname" {
  zone_id = module.woffenden_family_cloudflare_zone.id
  name    = "paperless"
  type    = "CNAME"
  value   = cloudflare_tunnel.paperless_woffenden_family.cname
  proxied = true
}

/* This record cannot be created as type of R2 is not supported yet
resource "cloudflare_record" "woffenden_io_cdn_r2" {
  zone_id = module.woffenden_io_cloudflare_zone.id
  name    = "cdn"
  type    = "R2"
  value   = "cdn-woffenden-io"
  proxied = true
}
*/

resource "cloudflare_record" "woffenden_io_github_pages_challenge" {
  zone_id = module.woffenden_io_cloudflare_zone.id
  name    = "_github-pages-challenge-woffenden"
  type    = "TXT"
  value   = "3e8f0954722b4e4341b822e923bf87"
}

resource "cloudflare_record" "woffenden_io_github_organisation_challenge" {
  zone_id = module.woffenden_io_cloudflare_zone.id
  name    = "_github-challenge-woffenden-organization"
  type    = "TXT"
  value   = "7714018f85"
}

resource "cloudflare_record" "woffenden_net_udmp_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "udmp.int.bny"
  type    = "A"
  value   = "10.100.0.1"
}

resource "cloudflare_record" "woffenden_net_nuc01_int_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "nuc01.int.bny"
  type    = "A"
  value   = "10.100.0.50"
}

resource "cloudflare_record" "woffenden_net_managed_network_cloudflare_bny" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "managed-network.cloudflare.bny"
  type    = "A"
  value   = "10.100.0.52"
}

resource "cloudflare_record" "woffenden_net_unifi_cname" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "unifi"
  type    = "CNAME"
  value   = cloudflare_tunnel.bny_woffenden_net.cname
  proxied = true
}

resource "cloudflare_record" "woffenden_net_bny_a" {
  zone_id = module.woffenden_net_cloudflare_zone.id
  name    = "bny"
  type    = "A"
  value   = "1.1.1.1"
  comment = "This record is updated by the IP Update script"

  lifecycle {
    ignore_changes = [value]
  }
}
