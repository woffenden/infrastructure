resource "aws_ssoadmin_permission_set" "administrator_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "AdministratorAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "administrator_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_ssoadmin_permission_set" "read_only_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ReadOnlyAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "read_only_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.read_only_access.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_ssoadmin_permission_set" "security_audit" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "SecurityAudit"
}

resource "aws_ssoadmin_managed_policy_attachment" "security_audit" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.security_audit.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_ssoadmin_permission_set" "view_only_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ViewOnlyAccess"
}

resource "aws_ssoadmin_managed_policy_attachment" "view_only_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.view_only_access.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
