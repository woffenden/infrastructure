data "aws_iam_policy_document" "aws_sso_sync_assume" {
  statement {
    sid     = "AllowAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws_sso_sync" {
  name               = "aws-sso-sync"
  assume_role_policy = data.aws_iam_policy_document.aws_sso_sync_assume.json
}

resource "aws_iam_role_policy_attachment" "aws_sso_sync_lambda_execution" {
  role       = aws_iam_role.aws_sso_sync.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "aws_sso_sync" {
  role       = aws_iam_role.aws_sso_sync.name
  policy_arn = aws_iam_policy.aws_sso_sync.arn
}
