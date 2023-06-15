data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
    }
  }
  statement {
    sid    = "AllowCloudWatchLogGroup"
    effect = "Allow"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    resources = ["*"]
    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:woffenden-organisation-cloudtrail"]
    }
  }
}

module "kms_key" {
  source = "../../../kms/modules/key"
  alias  = "woffenden-organisation-cloudtrail"
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
  source      = "../../../s3/modules/private-bucket"
  bucket_name = "woffenden-organisation-cloudtrail"
  policy      = data.aws_iam_policy_document.s3_bucket.json
}

####

data "aws_iam_policy_document" "cloudtrail_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid       = "AWSCloudTrailCreateLogStream"
    effect    = "Allow"
    actions   = ["logs:CreateLogStream"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:woffenden-organisation-cloudtrail:log-stream:*"]
  }
  statement {
    sid       = "AWSCloudTrailPutLogEvents"
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:woffenden-organisation-cloudtrail:log-stream:*"]
  }
}

resource "aws_iam_policy" "cloudtrail" {
  name   = "woffenden-organisation-cloudtrail"
  policy = data.aws_iam_policy_document.cloudtrail.json
}

resource "aws_iam_role" "cloudtrail" {
  name               = "woffenden-organisation-cloudtrail"
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_assume.json
}

resource "aws_iam_role_policy_attachment" "cloudtrail" {
  role       = aws_iam_role.cloudtrail.name
  policy_arn = aws_iam_policy.cloudtrail.arn
}

####

module "cloudwatch_log_group" {
  source     = "../../../cloudwatch/modules/log-group"
  name       = "woffenden-organisation-cloudtrail"
  kms_key_id = module.kms_key.arn
}

####

resource "aws_cloudtrail" "this" {
  name                          = "woffenden-organisation-cloudtrail"
  s3_bucket_name                = "woffenden-organisation-cloudtrail"
  is_organization_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  is_multi_region_trail         = true
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  cloud_watch_logs_group_arn    = "${module.cloudwatch_log_group.arn}:*"
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
