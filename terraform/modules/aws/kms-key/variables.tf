variable "is_enabled" {
  type    = bool
  default = true
}
variable "key_usage" {
  type    = string
  default = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  type    = string
  default = "SYMMETRIC_DEFAULT"
}

variable "bypass_policy_lockout_safety_check" {
  type    = bool
  default = false
}

variable "deletion_window_in_days" {
  type    = number
  default = 30
}

variable "enable_key_rotation" {
  type    = bool
  default = true
}

variable "multi_region" {
  type    = bool
  default = false
}

variable "alias" {
  type = string
}

variable "policy" {
  type    = string
  default = ""
}