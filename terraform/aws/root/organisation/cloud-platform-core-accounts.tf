# module "organisation_account_cloud_platform_idam" {
#   source              = "../../../modules/aws/organisation/modules/account"
#   name                = "cloud-platform-idam"
#   organisational_unit = module.organisational_unit_cloud_platform_core.id
# }

# module "organisation_account_cloud_platform_shared_services" {
#   source              = "../../../modules/aws/organisation/modules/account"
#   name                = "cloud-platform-shared-services"
#   organisational_unit = module.organisational_unit_cloud_platform_core.id
# }
