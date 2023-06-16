module "test" {
  source        = "../../../../modules/aws/ecr/modules/repository"
  account_alias = "test"
}
