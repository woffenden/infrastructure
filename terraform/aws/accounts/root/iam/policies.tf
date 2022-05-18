##### IAM Self Service with MFA

data "aws_iam_policy_document" "iam_self_serve_mfa_enforcement" {
  statement {
    sid = "AllowViewAccountInfo"
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:ListVirtualMFADevices"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    sid = "AllowManageOwnPasswords"
    actions = [
      "iam:ChangePassword",
      "iam:GetUser"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/&{aws:username}"]
  }
  statement {
    sid = "AllowManageOwnAccessKeys"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/&{aws:username}"]
  }
  statement {
    sid = "AllowManageOwnSigningCertificates"
    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/&{aws:username}"]
  }
  statement {
    sid = "AllowManageOwnSSHPublicKeys"
    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]
    resources = ["arn:aws:iam::*:user/&{aws:username}"]
  }
  statement {
    sid = "AllowManageOwnGitCredentials"
    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential"
    ]
    resources = ["arn:aws:iam::*:user/&{aws:username}"]
  }
  statement {
    sid = "AllowManageOwnVirtualMFADevice"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:mfa/&{aws:username}"]
  }
  statement {
    sid = "AllowManageOwnUserMFA"
    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::*:user/&{aws:username}"]
  }
  statement {
    sid = "DenyAllExceptListedIfNoMFA"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
      "iam:ChangePassword",
      "iam:GetAccountPasswordPolicy"
    ]
    effect    = "Deny"
    resources = ["*"]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}

resource "aws_iam_policy" "iam_self_serve_mfa_enforcement" {
  name   = "iam-self-serve-mfa-enforcement-policy"
  policy = data.aws_iam_policy_document.iam_self_serve_mfa_enforcement.json
}

resource "aws_iam_group_policy_attachment" "iam_self_serve_mfa_enforcement" {
  group      = module.group_all_users.name
  policy_arn = aws_iam_policy.iam_self_serve_mfa_enforcement.arn
}

#### 

# data "aws_iam_policy_document" "aws_administrator_assume_role" {
#   statement {
#     sid       = "AwsAdminAssumeRole"
#     actions   = ["sts:AssumeRole"]
#     effect    = "Allow"
#     resources = [aws_iam_role.aws_administrator.arn]
#   }
# }

# resource "aws_iam_policy" "aws_administrator" {
#   name   = "aws-administrator-policy"
#   policy = data.aws_iam_policy_document.aws_administrator_assume_role.json
# }

# resource "aws_iam_group_policy_attachment" "aws_administrator" {
#   group      = module.group_aws_administrators.name
#   policy_arn = aws_iam_policy.aws_administrator.arn
# }

###

# data "aws_iam_policy_document" "aws_organisation_administrator_assume_role" {
#   statement {
#     sid     = "AllowAssumeAWSOrgAdminRole"
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"
#     resources = formatlist("arn:aws:iam::%s:role/organisation-administrator-role", values(var.woffenden_aws_account_ids))
#   }
# }

# resource "aws_iam_policy" "aws_organisation_administrator" {
#   name   = "aws-organisation-administrator-policy"
#   policy = data.aws_iam_policy_document.aws_organisation_administrator_assume_role.json
# }

# resource "aws_iam_group_policy_attachment" "aws_organisation_administrator" {
#   group      = module.group_aws_administrators.name
#   policy_arn = aws_iam_policy.aws_organisation_administrator.arn
# }
