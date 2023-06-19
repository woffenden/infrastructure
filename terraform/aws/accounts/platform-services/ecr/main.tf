module "ecr_repositories" {
  for_each = local.ecr_repositories
  source   = "../../../../modules/aws/ecr/modules/repository"

  name          = each.value.name
  pull_accounts = each.value.pull_accounts
}
