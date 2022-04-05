data "aws_iam_policy_document" "kms_key" {
  statement {
    sid    = "AllowCloudTrailEncryption"
    effect = "Allow"
    actions = [
      "kms:GenerateDataKey*"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }
  statement {
    sid    = "AllowCloudTrailDescribeKey"
    effect = "Allow"
    actions = [
      "kms:DescribeKey"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "AllowPrincipalDecryption"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    resources = [
      "*"
    ]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = [
        data.aws_caller_identity.current.account_id
      ]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values = [
        "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
      ]
    }
  }
}

module "kms_key" {
  source = "../kms-key"
  alias  = "woffenden-organisation-cloudtrail-kms-key"
  policy = data.aws_iam_policy_document.kms_key.json
}
