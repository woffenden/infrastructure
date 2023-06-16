module "ecr_repositories" {
  for_each = local.ecr_repositories
  source   = "../../../../modules/aws/ecr/modules/repository"

  name      = each.value.name
  push_arns = each.value.push_arns
  pull_arns = each.value.pull_arns
}
