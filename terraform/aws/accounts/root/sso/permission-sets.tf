resource "aws_ssoadmin_permission_set" "aws_administrator_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "AWSAdministratorAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "aws_administrator_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.aws_administrator_access.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSAdministratorAccess"
}
