variable "name" {
  type = string
}

variable "retention_in_days" {
  type    = number
  default = 365
}

variable "kms_key_id" {
  type = string
}
