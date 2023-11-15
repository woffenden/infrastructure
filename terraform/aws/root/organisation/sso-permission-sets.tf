resource "aws_ssoadmin_permission_set" "cloud_platform_administrator" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "cloud-platform-administrator"
}

resource "aws_ssoadmin_managed_policy_attachment" "cloud_platform_administrator_administrator_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.cloud_platform_administrator.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_ssoadmin_permission_set" "cloud_platform_view_only" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "cloud-platform-view-only"
}

resource "aws_ssoadmin_managed_policy_attachment" "cloud_platform_view_only_view_only_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.cloud_platform_view_only.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
