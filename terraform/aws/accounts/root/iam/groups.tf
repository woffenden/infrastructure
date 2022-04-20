module "group_all_users" {
  source = "../../../../modules/aws/iam-group"
  name   = "all-users-group"
}

module "group_offboarded_users" {
  source = "../../../../modules/aws/iam-group"
  name   = "offboarded-users-group"
}

module "group_aws_administrators" {
  source = "../../../../modules/aws/iam-group"
  name   = "aws-administrators-group"
}
