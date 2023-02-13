/* Provider */
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

/* Route53 */
data "aws_route53_zone" "main" {
  name         = "aws.woffenden.cloud."
}

/* Module */
module "commonfate" {
  source = "github.com/chrnorm/terraform-aws-commonfate?ref=v0-11-update"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
   }

   /* tfscaffold crap */
   project        = "cf"
   environment    = "test"
   group          = "test"
   component      = "sso"
   aws_account_id = data.aws_caller_identity.current.account_id
   region         = data.aws_region.current.name

   aws_sso_identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
   aws_sso_instance_arn      = tolist(data.aws_ssoadmin_instances.main.arns)[0]
   aws_sso_region            = data.aws_region.current.name

  #  public_hosted_zone_id = data.aws_route53_zone.main.zone_id

   sources_version        = "v0.12.2"
   administrator_group_id = "commonfate-administrators"
   identity_provider_type = "cognito"
}