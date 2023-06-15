variable "allow_users_to_change_password" {
  type        = bool
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#allow_users_to_change_password"
  default     = true
}

variable "hard_expiry" {
  type        = bool
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#hard_expiry"
  default     = false
}

variable "max_password_age" {
  type        = number
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#max_password_age"
  default     = 90
}

variable "minimum_password_length" {
  type        = number
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#minimum_password_length"
  default     = 14
}

variable "password_reuse_prevention" {
  type        = number
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#password_reuse_prevention"
  default     = 5
}

variable "require_lowercase_characters" {
  type        = bool
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_lowercase_characters"
  default     = true
}

variable "require_numbers" {
  type        = bool
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_numbers"
  default     = true
}

variable "require_symbols" {
  type        = bool
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_symbols"
  default     = true
}

variable "require_uppercase_characters" {
  type        = bool
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_uppercase_characters"
  default     = true
}
