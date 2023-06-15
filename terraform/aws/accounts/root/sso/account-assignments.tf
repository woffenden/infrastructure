# resource "aws_ssoadmin_account_assignment" "development_aws_administrators" {
#   instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]

#   permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn

#   principal_type = "GROUP"
#   principal_id   = aws_identitystore_group.aws_administrators.group_id

#   target_type = "AWS_ACCOUNT"
#   target_id   = "258310932460"
# }
