data "cloudflare_access_identity_provider" "google_workspace" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "woffenden.io"
}

data "cloudflare_access_identity_provider" "github" {
  account_id = "af790e83102c7ab5347e7dfbf86ef021"
  name       = "woffenden"
}
