variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "privacy" {
  type    = string
  default = "closed"
}

variable "parent_team_id" {
  type    = string
  default = null
}

variable "maintainers" {
  type    = list(string)
  default = []
}


variable "members" {
  type    = list(string)
  default = []
}
