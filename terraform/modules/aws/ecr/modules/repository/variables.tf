variable "name" {
  type        = string
  description = "Name of the repository"
}

variable "force_delete" {
  type        = bool
  description = "If true, the repository will be deleted even if it contains images"
  default     = false
}

variable "image_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  default     = "MUTABLE"
}

variable "encryption_type" {
  type        = string
  description = "The encryption type to use for the repository. Must be one of: AES256 or KMS"
  default     = "KMS"
}

variable "scan_on_push" {
  type        = bool
  description = "If true, images will be scanned after being pushed to the repository"
  default     = true
}

variable "push_arns" {
  type        = list(string)
  description = "List of IAM ARNs that can push and pull images and tags."
  default     = []
}

variable "pull_accounts" {
  type        = list(string)
  description = "List of AWS accounts that can pull images."
  default     = []
}
