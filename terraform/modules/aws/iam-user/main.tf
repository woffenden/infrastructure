resource "aws_iam_user" "this" {
  name = var.email_address
  path = var.path
}

resource "aws_iam_user_group_membership" "this" {
  user   = aws_iam_user.this.name
  groups = var.groups
}

resource "aws_iam_user_login_profile" "this" {
  count = var.enabled ? 1 : 0

  user = aws_iam_user.this.name
}
