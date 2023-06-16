locals {
  name_lower             = lower(var.name)
  name_sanitised         = replace(local.name_lower, " ", "-")
  email_address_template = "ddat.aws+{replace_me}@woffenden.io"
  email                  = replace(local.email_address_template, "{replace_me}", local.name_sanitised)
}

variable "name" {
  type = string
}

variable "organisational_unit" {
  type = string
}

variable "role_name" {
  type    = string
  default = "organisation-administrator-role"
}

variable "iam_user_access_to_billing" {
  type    = string
  default = "ALLOW"
}

variable "close_on_deletion" {
  type    = bool
  default = true
}
