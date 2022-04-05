data "cloudflare_zone" "woffenden_io" {
  name = "woffenden.io"
}

module "woffenden_io_mta_sts" {
  source             = "../../../modules/google/mta-sts"
  domain             = "woffenden.io"
  cloudflare_zone_id = data.cloudflare_zone.woffenden_io.id
}
