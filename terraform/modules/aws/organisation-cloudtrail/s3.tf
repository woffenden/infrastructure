data "aws_iam_policy_document" "s3_bucket" {
  
}

module "s3_bucket" {
  source      = "../s3-bucket"
  bucket_name = "woffenden-organisation-cloudtrail"
  policy
}
