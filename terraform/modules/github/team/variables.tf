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

variable "members" {
  type    = list(string)
  default = []
}
