data "aws_iam_policy_document" "this" {
  source_json = var.policy
  statement {
    sid = "DenyInsecureTransport"
    actions = [
      "s3:*"
    ]
    effect = "Deny"
    principals {
      type = "*"
      identifiers = [
        "*"
      ]
    }
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.bucket_acl
}