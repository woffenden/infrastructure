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
  default     = "AES256"
}

variable "kms_key" {
  type        = string
  description = "The ARN of the KMS key to use when encrypting the repository. If not specified, uses the default AWS managed key for ECR"
  default     = null
}

variable "scan_on_push" {
  type        = bool
  description = "If true, images will be scanned after being pushed to the repository"
  default     = true
}
