module "iam_account_alias" {
  source        = "../../../modules/aws/iam/modules/account-alias"
  account_alias = "woffenden-production"
}

module "iam_account_password_policy" {
  source = "../../../modules/aws/iam/modules/account-password-policy"
}
