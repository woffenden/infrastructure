data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

####

resource "aws_guardduty_detector" "this" {
  enable                       = true
  finding_publishing_frequency = "ONE_HOUR"
}

resource "aws_guardduty_organization_admin_account" "this" {
  admin_account_id = data.aws_caller_identity.current.account_id
}

resource "aws_guardduty_organization_configuration" "this" {
  detector_id                      = aws_guardduty_detector.this.id
  auto_enable_organization_members = "ALL"

  datasources {
    s3_logs {
      auto_enable = true
    }
    kubernetes {
      audit_logs {
        enable = true
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          auto_enable = true
        }
      }
    }
  }
}

####

data "aws_iam_policy_document" "kms_key" {
  statement {
    sid     = "AllowGuardDutyEncryption"
    effect  = "Allow"
    actions = ["kms:GenerateDataKey*"]
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:guardduty:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:detector/${aws_guardduty_detector.this.id}"]
    }
  }
}

module "kms_key" {
  source = "../../../kms/modules/key"
  alias  = "woffenden-organisation-guardduty"
  policy = data.aws_iam_policy_document.kms_key.json
}

####

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    sid     = "AllowGuardDutygetBucketLocation"
    effect  = "Allow"
    actions = ["s3:GetBucketLocation"]
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::woffenden-organisation-guardduty"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:guardduty:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:detector/${aws_guardduty_detector.this.id}"]
    }
  }
  statement {
    sid     = "AllowGuardDutyPutObject"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::woffenden-organisation-guardduty/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:guardduty:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:detector/${aws_guardduty_detector.this.id}"]
    }
  }
}

module "s3_bucket" {
  source      = "../../../s3/modules/private-bucket"
  bucket_name = "woffenden-organisation-guardduty"
  policy      = data.aws_iam_policy_document.s3_bucket.json
}

####

resource "aws_guardduty_publishing_destination" "this" {
  detector_id     = aws_guardduty_detector.this.id
  destination_arn = module.s3_bucket.arn
  kms_key_arn     = module.kms_key.arn

  depends_on = [module.s3_bucket]
}
