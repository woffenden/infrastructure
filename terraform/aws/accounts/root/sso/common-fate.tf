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
  source = "github.com/chrnorm/terraform-aws-commonfate?ref=aws-sso-support"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
   }

   project        = "cf"
   environment    = "test"
   component      = "sso"
   aws_account_id = data.aws_caller_identity.current.account_id
   region         = data.aws_region.current.name

   aws_sso_identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
   aws_sso_instance_arn      = tolist(data.aws_ssoadmin_instances.main.arns)[0]
   aws_sso_region            = data.aws_region.current.name

   sources_version        = "v0.12.2"

   identity_provider_type = "aws-sso"
   identity_provider_name = "AWS"
   administrator_group_id = "36829224-d021-7054-143f-5bd2c754e750" # commonfate-administrators

  saml_sso_metadata_content = ""
  saml_sso_metadata_url     = "https://portal.sso.eu-west-2.amazonaws.com/saml/metadata/NzQ5MDE5MTU1NjA1X2lucy00ZDY1NTQyZjUwMjgwNDNj"
}