data "aws_caller_identity" "session" {
  provider = aws.session
}

data "aws_iam_session_context" "session" {
  provider = aws.session

  arn = data.aws_caller_identity.session.arn
}

data "aws_region" "current" {}

data "aws_ssoadmin_instances" "main" {}

data "aws_organizations_organization" "main" {}

data "aws_secretsmanager_secret_version" "aws_sso_sync_scim_token" {
  secret_id = "aws-sso-sync/scim-token"
}

data "aws_secretsmanager_secret_version" "aws_sso_sync_scim_endpoint" {
  secret_id = "aws-sso-sync/scim-endpoint"
}

data "aws_secretsmanager_secret_version" "aws_sso_sync_google_admin" {
  secret_id = "aws-sso-sync/google-admin"
}

data "aws_secretsmanager_secret_version" "aws_sso_sync_google_credentials" {
  secret_id = "aws-sso-sync/google-credentials"
}

data "aws_secretsmanager_secret_version" "github_token" {
  secret_id = "github-robot-token"
}
