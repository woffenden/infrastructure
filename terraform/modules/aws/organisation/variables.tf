variable "aws_service_access_principals" {
  type        = list(string)
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#aws_service_access_principals"
  default = [
    "access-analyzer.amazonaws.com",
    "account.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "compute-optimizer.amazonaws.com",
    "config.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com",
    "detective.amazonaws.com",
    "guardduty.amazonaws.com",
    "health.amazonaws.com",
    "inspector2.amazonaws.com",
    "ipam.amazonaws.com",
    "malware-protection.guardduty.amazonaws.com",
    "ram.amazonaws.com",
    "reporting.trustedadvisor.amazonaws.com",
    "securityhub.amazonaws.com",
    "sso.amazonaws.com",
    "storage-lens.s3.amazonaws.com",
    "ssm.amazonaws.com",
    "tagpolicies.tag.amazonaws.com"
  ]
}

variable "enabled_policy_types" {
  type        = list(string)
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#enabled_policy_types"
  default = [
    "AISERVICES_OPT_OUT_POLICY",
    "BACKUP_POLICY",
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}

variable "feature_set" {
  type        = string
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization#feature_set"
  default     = "ALL"
}