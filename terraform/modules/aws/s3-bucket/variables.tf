variable "bucket_name" {
  type = string
}

variable "bucket_acl" {
  type = string
  default = "private"
}

variable "policy" {
  type    = string
  default = ""
}