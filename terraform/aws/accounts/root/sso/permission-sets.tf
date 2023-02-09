resource "aws_ssoadmin_permission_set" "aws_administrator_access" {
  name         = "AWSAdministratorAccess"
  instance_arn = tolist(data.aws_ssoadmin_instances.example.arns)[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "aws_administrator_access" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  permission_set_arn = aws_ssoadmin_permission_set.aws_administrator_access
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSAdministratorAccess"
}
