data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

####

data "aws_iam_policy_document" "kms_key" {
  statement {
    sid = "AWSConfigKMSPolicy"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*"
    ]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

module "kms_key" {
  source = "../../../kms/modules/key"
  alias  = "woffenden-organisation-config"
  policy = data.aws_iam_policy_document.kms_key.json
}

####

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
  statement {
    sid = "AWSConfigBucketExistenceCheck"
    effect = "Allow"
    actions = ["s3:ListBucket"]
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
  statement {
    sid = "AWSConfigBucketDelivery"
    effect = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::woffenden-organisation-config/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

module "s3_bucket" {
  source      = "../../../s3/modules/private-bucket"
  bucket_name = "woffenden-organisation-config"
  policy      = data.aws_iam_policy_document.s3_bucket.json
}

####

data "aws_iam_policy_document" "config_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "config" {
  statement {
    sid       = "AWSConfigBucketS3Access"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      "arn:aws:s3:::woffenden-organisation-config",
      "arn:aws:s3:::woffenden-organisation-config/*",
    ]
  }
}

resource "aws_iam_policy" "config" {
  name   = "woffenden-organisation-config"
  policy = data.aws_iam_policy_document.config.json
}

resource "aws_iam_role" "config" {
  name               = "woffenden-organisation-config"
  assume_role_policy = data.aws_iam_policy_document.config_assume.json
}

resource "aws_iam_role_policy_attachment" "config" {
  role       = aws_iam_role.config.name
  policy_arn = aws_iam_policy.config.arn
}

resource "aws_iam_role_policy_attachment" "organisation" {
  role       = aws_iam_role.config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

####

resource "aws_config_configuration_recorder" "this" {
  name = "woffenden-organisation-config"
  role_arn = aws_iam_role.config.arn
}

resource "aws_config_configuration_aggregator" "organisation" {
  name = "woffenden-organisation-config-aggregator"

  organization_aggregation_source {
    all_regions = true
    role_arn    = aws_iam_role.config.arn
  }

  depends_on = [aws_iam_role_policy_attachment.organisation]
}

resource "aws_config_delivery_channel" "name" {
  name = "woffenden-organisation-config-s3"
  s3_bucket_name = module.s3_bucket.id
  s3_kms_key_arn = module.kms_key.arn
}
