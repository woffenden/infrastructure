# # This won't create: AccessDenied: Cannot find Service Linked Role template for account.amazonaws.com
# # resource "aws_iam_service_linked_role" "account_management" {
# #   aws_service_name = "account.amazonaws.com"
# # }

# resource "aws_organizations_delegated_administrator" "cloud_platform_idam_account_management" {
#   account_id        = module.organisation_account_cloud_platform_idam.id
#   service_principal = "account.amazonaws.com"

#   # depends_on = [aws_iam_service_linked_role.account_management]
# }

# # This won't create: InvalidInput: Service role name AWSServiceRoleForCloudTrail has been taken in this account, please try a different suffix.
# # resource "aws_iam_service_linked_role" "cloudtrail" {
# #   aws_service_name = "cloudtrail.amazonaws.com"
# # }

# resource "aws_organizations_delegated_administrator" "cloud_platform_idam_cloudtrail" {
#   account_id        = module.organisation_account_cloud_platform_idam.id
#   service_principal = "cloudtrail.amazonaws.com"

#   # depends_on = [aws_iam_service_linked_role.cloudtrail]
# }

# # This won't create: InvalidInput: Service role name AWSServiceRoleForSSO has been taken in this account, please try a different suffix.
# # resource "aws_iam_service_linked_role" "identity_centre" {
# #   aws_service_name = "sso.amazonaws.com"
# # }

# resource "aws_organizations_delegated_administrator" "cloud_platform_idam_identity_centre" {
#   account_id        = module.organisation_account_cloud_platform_idam.id
#   service_principal = "sso.amazonaws.com"

#   # depends_on = [aws_iam_service_linked_role.identity_centre]
# }
