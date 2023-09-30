module "organisational_unit_cloud_platform_core" {
  source    = "../../../modules/aws/organisation/modules/organisational-unit"
  name      = "cloud-platform-core"
  parent_id = module.organisation.root_id
}

module "organisational_unit_cloud_platform_tenants" {
  source    = "../../../modules/aws/organisation/modules/organisational-unit"
  name      = "cloud-platform-tenants"
  parent_id = module.organisation.root_id
}

module "organisational_unit_cloud_platform_graveyard" {
  source    = "../../../modules/aws/organisation/modules/organisational-unit"
  name      = "cloud-platform-graveyard"
  parent_id = module.organisation.root_id
}
