data "cloudflare_zone" "woffenden_net" {
  name = "woffenden.net"
}

module "woffenden_net_mta_sts" {
  source             = "../../../modules/google/mta-sts"
  domain             = "woffenden.net"
  cloudflare_zone_id = data.cloudflare_zone.woffenden_net.id
}
