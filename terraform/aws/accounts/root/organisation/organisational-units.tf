module "organisational_unit_shared_services" {
  source    = "../../../../modules/aws/organisational-unit"
  name      = "Shared Services"
  parent_id = module.organisation.root_id
}

module "organisational_unit_notproduction" {
  source    = "../../../../modules/aws/organisational-unit"
  name      = "Not Production"
  parent_id = module.organisation.root_id
}

module "organisational_unit_production" {
  source    = "../../../../modules/aws/organisational-unit"
  name      = "Production"
  parent_id = module.organisation.root_id
}
