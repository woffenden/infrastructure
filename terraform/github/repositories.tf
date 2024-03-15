#ts:skip=accurics.github.IAM.1
module "infrastructure_repository" {
  #ts:skip=accurics.github.IAM.1

  source = "../modules/github/repository"

  name                                              = "infrastructure"
  description                                       = null
  use_template                                      = false
  has_projects                                      = true
  has_wiki                                          = false
  homepage_url                                      = "https://woffenden.github.io/infrastructure/"
  pages_enabled                                     = true
  branch_protection_required_status_checks_contexts = ["Super-Linter"]
  access = {
    admins = [module.cloud_platform_team.id]
    pushers = [
      module.container_platform_team.id,
      module.observability_platform_team.id
    ]
  }
}
