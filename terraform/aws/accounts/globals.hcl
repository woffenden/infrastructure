inputs = {
  /* woffenden_terraform_config resources were created using cloudformation/root-account-bootstrap.yaml */
  woffenden_terraform_config = {
    s3_bucket      = "woffenden-terraform"
    kms_key_id     = "arn:aws:kms:eu-west-2:749019155605:key/e68a6c13-c02f-4bc2-bf92-03b0edf55b4d"
    dynamodb_table = "terraform"
  }
  woffenden_aws_region = "eu-west-2"
  woffenden_aws_account_ids = {
    root            = "749019155605"
    shared-services = "568160031979"
    development     = "258310932460"
    production      = "655105654343"
  }
  woffenden_aws_iam_roles = {
    root            = "arn:aws:iam::749019155605:role/github-actions"
    shared-services = "arn:aws:iam::568160031979:role/organisation-administrator-role"
    development     = "arn:aws:iam::258310932460:role/organisation-administrator-role"
    production      = "arn:aws:iam::655105654343:role/organisation-administrator-role"
  }
}