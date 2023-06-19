resource "aws_lambda_permission" "aws_sso_sync" {
  function_name = aws_lambda_function.aws_sso_sync.function_name
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
}