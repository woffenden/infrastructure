variable "name" {
  type = string
}

variable "account" {
  type = string
}

variable "access" {
  type = list(object({
    google_group = string
    role         = string
  }))
}
