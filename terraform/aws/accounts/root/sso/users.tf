resource "aws_identitystore_user" "jacobwoffenden" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]

  display_name = "Jacob Woffenden"
  user_name    = "jacob@woffenden.io"

  name {
    given_name  = "Jacob"
    family_name = "Woffenden"
  }

  emails {
    value = "jacob@woffenden.io"
  }
}

resource "aws_identitystore_group_membership" "jacobwoffenden_commonfate_administrators" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  member_id         = aws_identitystore_user.jacobwoffenden.user_id
  group_id          = aws_identitystore_group.commonfate_administrators.group_id
}
