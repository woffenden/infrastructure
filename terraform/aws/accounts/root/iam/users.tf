module "user_jacobwoffenden" {
  source        = "../../../../modules/aws/iam-user"
  enabled       = true
  full_name     = "Jacob Woffenden"
  email_address = "jacob@woffenden.io"
  groups = [
    module.group_all_users.name,
    module.group_aws_administrators.name
  ]
}

module "user_test" {
  source        = "../../../../modules/aws/iam-user"
  enabled       = false
  full_name     = "Test User"
  email_address = "test@woffenden.io"
  groups = [module.group_offboarded_users.name]
}
