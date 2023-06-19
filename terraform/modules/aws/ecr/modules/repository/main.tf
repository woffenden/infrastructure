data "aws_region" "current" {}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.force_delete

  encryption_configuration {
    encryption_type = var.encryption_type
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "CrossAccountPermission"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.pull_accounts)
    }
  }
  statement {
    sid = "LambdaECRImageCrossAccountRetrievalPolicy"
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "aws:sourceArn"
      values   = formatlist("arn:aws:lambda:${data.aws_region.current.name}:%s:function:*", var.account_id)
    }
  }
}

resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.this.json
}
