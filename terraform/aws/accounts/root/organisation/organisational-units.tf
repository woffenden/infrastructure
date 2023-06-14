module "organisational_unit_core" {
  source = "../../../../modules/aws/organisation/modules/ou"
  name      = "Core"
  parent_id = module.organisation.root_id
}

module "organisational_unit_notproduction" {
  source = "../../../../modules/aws/organisation/modules/ou"
  name      = "Not Production"
  parent_id = module.organisation.root_id
}

module "organisational_unit_production" {
  source = "../../../../modules/aws/organisation/modules/ou"
  name      = "Production"
  parent_id = module.organisation.root_id
}
