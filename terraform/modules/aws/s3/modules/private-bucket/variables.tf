variable "bucket_name" {
  type = string
}

variable "bucket_versioning" {
  type    = string
  default = "Disabled"
}

variable "policy" {
  type    = string
  default = ""
}
