variable "allow_users_to_change_password" {
  type        = bool
  description = "TBC"
  default     = true
}

variable "hard_expiry" {
  type        = bool
  description = "TBC"
  default     = false
}

variable "max_password_age" {
  type        = number
  description = "TBC"
  default     = 90
}

variable "minimum_password_length" {
  type        = number
  description = "TBC"
  default     = 14
}

variable "password_reuse_prevention" {
  type        = number
  description = "TBC"
  default     = 5
}

variable "require_lowercase_characters" {
  type        = bool
  description = "TBC"
  default     = true
}

variable "require_numbers" {
  type        = bool
  description = "TBC"
  default     = true
}

variable "require_symbols" {
  type        = bool
  description = "TBC"
  default     = true
}

variable "require_uppercase_characters" {
  type        = bool
  description = "TBC"
  default     = true
}