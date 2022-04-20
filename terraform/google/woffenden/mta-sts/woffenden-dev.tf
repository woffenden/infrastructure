data "cloudflare_zone" "woffenden_dev" {
  name = "woffenden.dev"
}

module "woffenden_dev_mta_sts" {
  source             = "../../../modules/google/mta-sts"
  domain             = "woffenden.dev"
  cloudflare_zone_id = data.cloudflare_zone.woffenden_dev.id
}
