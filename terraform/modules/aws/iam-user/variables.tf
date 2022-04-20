variable "full_name" {
  type        = string
  description = "User's full name e.g. Jacob Woffenden"
}

variable "email_address" {
  type        = string
  description = "User's email address e.g. jacob@woffenden.io"
}

variable "enabled" {
  type        = bool
  description = "Enables or disables the user"
  default     = true
}

variable "path" {
  type        = string
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user#path"
  default     = "/"
}

variable "groups" {
  type        = list(string)
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership#groups"
}
