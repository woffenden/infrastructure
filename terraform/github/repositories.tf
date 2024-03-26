module "infrastructure_repository" {
  #ts:skip=accurics.github.IAM.1

  source = "../modules/github/repository"

  name                                              = "infrastructure"
  description                                       = "Infrastructure"
  use_template                                      = false
  has_projects                                      = true
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

module "template_repository" {
  #ts:skip=accurics.github.IAM.1

  source = "../modules/github/repository"

  name                                              = "template-repository"
  description                                       = "Template repository"
  is_template                                       = true
  use_template                                      = false
  branch_protection_required_status_checks_contexts = ["Super-Linter"]
  access = {
    admins = [module.cloud_platform_team.id]
  }
}

module "devcontainer_repository" {
  #ts:skip=accurics.github.IAM.1

  source = "../modules/github/repository"

  name                                              = ".devcontainer"
  description                                       = "Dev Container images and features"
  use_template                                      = true
  branch_protection_required_status_checks_contexts = ["Super-Linter"]
  access = {
    admins = [module.cloud_platform_team.id]
  }
}
