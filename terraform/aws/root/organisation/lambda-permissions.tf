resource "aws_lambda_permission" "aws_sso_sync" {
  function_name = aws_lambda_function.aws_sso_sync.arn
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
}
