data "aws_ssoadmin_instances" "main" {}

data "aws_ssoadmin_permission_set" "cloud_platform_administrator" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "cloud-platform-administrator"
}

data "aws_identitystore_group" "this" {
  for_each = { for i in var.access : i.google_group => i }

  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.key
    }
  }
}

resource "aws_ssoadmin_account_assignment" "cloud_platform_administrator" {
  for_each = {
    for i in var.access : i.google_group => i
    if i.role == "administrator"
  }

  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.cloud_platform_administrator.arn

  principal_type = "GROUP"
  principal_id   = data.aws_identitystore_group.this[each.key].group_id

  target_type = "AWS_ACCOUNT"
  target_id   = var.account
}
