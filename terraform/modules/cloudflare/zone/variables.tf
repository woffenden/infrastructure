variable "account" {
  type = string
}

variable "zone" {
  type = string
}

variable "plan" {
  type    = string
  default = "free"
}

variable "type" {
  type    = string
  default = "full"
}

variable "paused" {
  type    = bool
  default = false
}

variable "jump_start" {
  type    = bool
  default = false
}
