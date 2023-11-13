module "cloud_platform_environment_account" {
  for_each = { for env in local.environments : env.name => env }

  source = "../account"

  name                = "${local.name}-${each.key}"
  organisational_unit = var.organisational_unit
}

data "github_team" "this" {
  for_each = { for env in local.environments : env.name => env }

  slug = "${each.value.github_team}"
}

resource "github_repository_environment" "this" {
  for_each = { for env in local.environments : env.name => env }

  repository  = "infrastructure"
  environment = "${local.name}-${each.key}"

  reviewers {
    teams = [data.github_team.this[each.key].id]
  }
}
