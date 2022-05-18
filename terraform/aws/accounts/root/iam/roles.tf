data "aws_iam_policy_document" "aws_administrator_assume_account" {
  statement {
    sid     = "AwsAdminAssume"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_role" "aws_administrator" {
  name               = "aws-administrator-role"
  assume_role_policy = data.aws_iam_policy_document.aws_administrator_assume_account.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/job-function/Billing"
  ]
}