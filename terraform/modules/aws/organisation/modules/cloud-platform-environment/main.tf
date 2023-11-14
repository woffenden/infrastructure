module "cloud_platform_environment_account" {
  for_each = { for env in local.environments : env.name => env }

  source = "../account"

  name                = "${local.name}-${each.key}"
  organisational_unit = var.organisational_unit
}

module "cloud_platform_environment_access" {
  for_each = { for env in local.environments : env.name => env }

  source = "../cloud-platform-environment-access"

  name    = "${local.name}-${each.key}"
  account = module.cloud_platform_environment_account[each.key].id
  access  = each.value.access
}

data "github_team" "this" {
  for_each = { for env in local.environments : env.name => env }

  slug = each.value.github_team
}

resource "github_repository_environment" "this" {
  for_each = { for env in local.environments : env.name => env }

  repository  = "infrastructure"
  environment = "${local.name}-${each.key}"

  reviewers {
    teams = [data.github_team.this[each.key].id]
  }
}
