module "grigorieva_io_cloudflare_zone" {
  source = "../modules/cloudflare/zone"

  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "grigorieva.io"
}

# module "woffenden_cloud_cloudflare_zone" {
#   source = "../modules/cloudflare/zone"
#
#   account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
#   zone   = "woffenden.cloud"
# }

module "woffenden_dev_cloudflare_zone" {
  source  = "../modules/cloudflare/zone"
  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "woffenden.dev"
}

# module "woffenden_family_cloudflare_zone" {
#   source = "../modules/cloudflare/zone"
#
#   account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
#   zone   = "woffenden.family"
# }

module "woffenden_io_cloudflare_zone" {
  source = "../modules/cloudflare/zone"

  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "woffenden.io"
}

module "woffenden_net_cloudflare_zone" {
  source = "../modules/cloudflare/zone"

  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "woffenden.net"
}

module "woffendens_co_uk_cloudflare_zone" {
  source = "../modules/cloudflare/zone"

  account = data.google_secret_manager_secret_version.cloudflare_account_id.secret_data
  zone    = "woffendens.co.uk"
}
