data "aws_caller_identity" "current" {}

####

data "aws_iam_policy_document" "kms_key" {
  statement {
    sid     = "AllowCloudTrailEncryption"
    effect  = "Allow"
    actions = ["kms:GenerateDataKey*"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }
  statement {
    sid     = "AllowCloudTrailDescribeKey"
    effect  = "Allow"
    actions = ["kms:DescribeKey"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["*"]
  }
  statement {
    sid    = "AllowPrincipalDecryption"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["*"]
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
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }
}

module "kms_key" {
  source = "../kms-key"
  alias  = "woffenden-organisation-cloudtrail-kms-key"
  policy = data.aws_iam_policy_document.kms_key.json
}

####

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    sid     = "AWSCloudTrailAclCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::woffenden-organisation-cloudtrail"]
  }
  statement {
    sid     = "AWSCloudTrailWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::woffenden-organisation-cloudtrail/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

module "s3_bucket" {
  source      = "../s3-bucket-private"
  bucket_name = "woffenden-organisation-cloudtrail"
  policy      = data.aws_iam_policy_document.s3_bucket.json
}

####

resource "aws_cloudtrail" "this" {
  name                          = "woffenden-organisation-cloudtrail"
  s3_bucket_name                = "woffenden-organisation-cloudtrail"
  is_organization_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  # cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudwatch.arn}:*"
  # cloud_watch_logs_role_arn     = aws_iam_role.cloudwatch.arn
  kms_key_id                    = module.kms_key.arn
  event_selector {
    include_management_events = true
    read_write_type           = "All"

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3"]
    }
    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }
}