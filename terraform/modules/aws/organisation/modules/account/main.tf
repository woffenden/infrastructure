resource "random_id" "email_suffix" {
  byte_length = 8
}

resource "aws_organizations_account" "this" {
  name                       = var.name
  parent_id                  = var.organisational_unit
  email                      = local.email
  role_name                  = var.role_name
  iam_user_access_to_billing = var.iam_user_access_to_billing
  close_on_deletion          = var.close_on_deletion
  lifecycle {
    ignore_changes = [
      name,
      email,
      parent_id,
      iam_user_access_to_billing,
      role_name
    ]
  }
}
