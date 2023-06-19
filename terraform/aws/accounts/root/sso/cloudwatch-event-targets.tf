resource "aws_cloudwatch_event_target" "aws_sso_sync" {
  rule      = aws_cloudwatch_event_rule.aws_sso_sync.name
  target_id = "aws-sso-sync-lambda"
  arn       = aws_lambda_function.aws_sso_sync.arn
}