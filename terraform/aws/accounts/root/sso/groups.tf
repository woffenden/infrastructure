resource "aws_identitystore_group" "aws_administrators" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  display_name      = "aws-administrators"
  description       = "AWS Administrators"
}

resource "aws_identitystore_group" "commonfate_administrators" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  display_name      = "commonfate-administrators"
  description       = "Common Fate Administrators"
}
