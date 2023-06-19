data "aws_iam_policy_document" "aws_sso_sync" {
  statement {
    sid    = "IdentityStoreAccess"
    effect = "Allow"
    actions = [
      "identitystore:DeleteUser",
      "identitystore:CreateGroup",
      "identitystore:CreateGroupMembership",
      "identitystore:ListGroups",
      "identitystore:ListUsers",
      "identitystore:ListGroupMemberships",
      "identitystore:IsMemberInGroups",
      "identitystore:GetGroupMembershipId",
      "identitystore:DeleteGroupMembership",
      "identitystore:DeleteGroup"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "aws_sso_sync" {
  name   = "aws-sso-sync"
  policy = data.aws_iam_policy_document.aws_sso_sync.json
}