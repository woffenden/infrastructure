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
