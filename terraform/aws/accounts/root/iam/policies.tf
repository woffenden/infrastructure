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

###

data "aws_iam_policy_document" "aws_administrator_assume_role" {
  statement {
    sid = "AwsAdminAssumeRole"
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    resources = [
      aws_iam_role.aws_administrator.arn,
    ]
  }
}

resource "aws_iam_policy" "aws_administrator" {
  name   = "aws-administrator-policy"
  policy = data.aws_iam_policy_document.aws_administrator_assume_role.json
}

resource "aws_iam_group_policy_attachment" "aws_administrator" {
  group      = module.group_aws_administrators.name
  policy_arn = aws_iam_policy.aws_administrator.arn
}

# ###

# data "aws_iam_policy_document" "maglevlabs_org_admin_assume_role" {
#   statement {
#     sid = "AwsAdminAssumeRole"
#     actions = [
#       "sts:AssumeRole"
#     ]
#     effect = "Allow"
#     resources = [
#       "arn:aws:iam::${var.shared_services_account_id}:role/maglevlabs-organisations-admin@role.iam.aws.maglevlabs.com",
#       "arn:aws:iam::${var.demo_account_id}:role/maglevlabs-organisations-admin@role.iam.aws.maglevlabs.com"
#     ]
#   }
# }

# resource "aws_iam_policy" "maglevlabs_org_admin" {
#   name   = "terraform-organisations-admin@policy.iam.aws.maglevlabs.com"
#   policy = data.aws_iam_policy_document.maglevlabs_org_admin_assume_role.json
#   path   = "/maglevlabs/"
# }

# data "aws_iam_group" "terraform_svcacc_group" {
#   group_name = "terraform@group.iam.aws.maglevlabs.com"
# }

# resource "aws_iam_group_policy_attachment" "maglevlabs_org_admin_terraform_svcacc_group" {
#   group      = data.aws_iam_group.terraform_svcacc_group.group_name
#   policy_arn = aws_iam_policy.maglevlabs_org_admin.arn
# }
