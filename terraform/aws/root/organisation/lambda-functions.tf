resource "aws_lambda_function" "aws_sso_sync" {
  #ts:skip=AC_AWS_0485
  #ts:skip=AC_AWS_0486
  #ts:skip=AC_AWS_0483
  #ts:skip=AC_AWS_0484
  function_name = "aws-sso-sync"
  package_type  = "Image"
  image_uri     = "126246520815.dkr.ecr.eu-west-2.amazonaws.com/aws-ssosync:2.1.2"
  role          = aws_iam_role.aws_sso_sync.arn
  timeout       = 600

  environment {
    variables = {
      AWS_IDENTITY_STORE_ID           = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
      AWS_IDENTITY_STORE_REGION       = data.aws_region.current.name
      AWS_SSO_SYNC_GOOGLE_ADMIN       = data.aws_secretsmanager_secret_version.aws_sso_sync_google_admin.secret_string
      AWS_SSO_SYNC_GOOGLE_CREDENTIALS = data.aws_secretsmanager_secret_version.aws_sso_sync_google_credentials.secret_string
      AWS_SSO_SYNC_LOG_LEVEL          = "debug"
      AWS_SSO_SYNC_SCIM_ENDPOINT      = data.aws_secretsmanager_secret_version.aws_sso_sync_scim_endpoint.secret_string
      AWS_SSO_SYNC_SCIM_TOKEN         = data.aws_secretsmanager_secret_version.aws_sso_sync_scim_token.secret_string
      AWS_SSO_SYNC_IGNORE_GROUPS      = data.aws_secretsmanager_secret_version.aws_sso_sync_ignore_groups.secret_string
      AWS_SSO_SYNC_IGNORE_USERS       = data.aws_secretsmanager_secret_version.aws_sso_sync_ignore_users.secret_string
    }
  }
}
