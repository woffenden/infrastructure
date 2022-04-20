module "iam_account_alias" {
  source        = "../../../../modules/aws/iam-account-alias"
  account_alias = "woffenden-shared-services"
}

module "iam_account_password_policy" {
  source = "../../../../modules/aws/iam-account-password-policy"
}