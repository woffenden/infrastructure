# resource "cloudflare_teams_rule" "cloudflare_curated" {
#   account_id  = "af790e83102c7ab5347e7dfbf86ef021"
#   enabled     = true
#   name        = "cloudflare-curated-categories"
#   description = "Cloudflare curated rules"
#   action      = "block"
#   filters     = ["dns"]
#   precedence  = "8"
#   traffic     = "any(dns.security_category[*] in {117 80 83 131 151 153 178 68 176 175})"
#   rule_settings {
#     add_headers                        = {}
#     block_page_enabled                 = false
#     insecure_disable_dnssec_validation = false
#     override_ips                       = []
#   }
# }
