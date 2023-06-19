resource "aws_cloudwatch_event_rule" "aws_sso_sync" {
  name                = "aws-sso-sync"
  schedule_expression = "rate(3 hours)"
}
