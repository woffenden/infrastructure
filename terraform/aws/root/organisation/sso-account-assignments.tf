data "aws_identitystore_group" "cloud_platform" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "cloud-platform"
    }
  }
}

resource "aws_ssoadmin_account_assignment" "cloud_platform_cloud_platform_administrator_root" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.cloud_platform_administrator.arn

  principal_type = "GROUP"
  principal_id   = data.aws_identitystore_group.cloud_platform.group_id

  target_type = "AWS_ACCOUNT"
  target_id   = data.aws_organizations_organization.main.master_account_id
}

# resource "aws_ssoadmin_account_assignment" "cloud_platform_cloud_platform_administrator_organisation" {
#   for_each = {
#     for account in data.aws_organizations_organization.main.non_master_accounts :
#     account.id => account
#     if account.status == "ACTIVE"
#   }

#   instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
#   permission_set_arn = aws_ssoadmin_permission_set.cloud_platform_administrator.arn

#   principal_type = "GROUP"
#   principal_id   = data.aws_identitystore_group.cloud_platform.group_id

#   target_type = "AWS_ACCOUNT"
#   target_id   = each.value.id
# }
