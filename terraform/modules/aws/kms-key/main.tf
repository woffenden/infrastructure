data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  /* Extra policy passed in with var.policy */
  source_policy_documents = [var.policy]

  /* Default statement giving `aws_caller_identity.current.account_id` access */
  statement {
    sid    = "EnableIAMUserPermissions"
    effect = "Allow"
    actions = [
      "kms:*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
    resources = ["*"]
  }
}

resource "aws_kms_key" "this" {
  is_enabled                         = var.is_enabled
  key_usage                          = var.key_usage
  customer_master_key_spec           = var.customer_master_key_spec
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  enable_key_rotation                = var.enable_key_rotation
  policy                             = data.aws_iam_policy_document.this.json
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.this.key_id
}