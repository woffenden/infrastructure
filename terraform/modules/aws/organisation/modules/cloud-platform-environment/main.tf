module "cloud_platform_environment_account" {
  for_each = local.environments

  source = "../account"

  name                = "${local.name}-${each.key}"
  organisational_unit = var.organisational_unit
}
