module "organisation_account_development" {
  source              = "../../../../modules/aws/organisation/modules/account"
  name                = "Development"
  organisational_unit = module.organisational_unit_notproduction.id
}

module "organisation_account_production" {
  source              = "../../../../modules/aws/organisation/modules/account"
  name                = "Production"
  organisational_unit = module.organisational_unit_production.id
}
