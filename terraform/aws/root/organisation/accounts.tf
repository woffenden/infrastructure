module "organisation_account_cloud_platform_shared_services" {
  source              = "../../../modules/aws/organisation/modules/account"
  name                = "cloud-platform-shared-services"
  organisational_unit = module.organisational_unit_cloud_platform_core.id
}
