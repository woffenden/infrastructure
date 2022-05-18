module "organisation_account_shared_services" {
  source              = "../../../../modules/aws/organisation-account"
  name                = "Shared Services"
  organisational_unit = module.organisational_unit_shared_services.id
}

module "organisation_account_development" {
  source              = "../../../../modules/aws/organisation-account"
  name                = "Development"
  organisational_unit = module.organisational_unit_notproduction.id
}

module "organisation_account_production" {
  source              = "../../../../modules/aws/organisation-account"
  name                = "Production"
  organisational_unit = module.organisational_unit_production.id
}
