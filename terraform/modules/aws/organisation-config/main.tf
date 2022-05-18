data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    sid     = "AWSConfigBucketPermissionsCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::woffenden-organisation-config"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

module "s3_bucket" {
  source      = "../s3-bucket-private"
  bucket_name = "woffenden-organisation-config"
  policy      = data.aws_iam_policy_document.s3_bucket.json
}