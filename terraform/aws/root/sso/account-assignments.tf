data "aws_identitystore_group" "ddat_aws_sre" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "DDaT - AWS - SRE"
    }
  }
}

resource "aws_ssoadmin_account_assignment" "ddat_aws_sre_administrator_access_root" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn

  principal_id   = data.aws_identitystore_group.ddat_aws_sre.group_id
  principal_type = "GROUP"

  target_id   = "749019155605"
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "ddat_aws_sre_administrator_access_cloud_platform__shared_services" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn

  principal_id   = data.aws_identitystore_group.ddat_aws_sre.group_id
  principal_type = "GROUP"

  target_id   = "126246520815"
  target_type = "AWS_ACCOUNT"
}
