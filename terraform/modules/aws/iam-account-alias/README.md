# iam-account-alias

This Terraform module creates an AWS IAM account alias

## Usage

```hcl
module "iam_account_alias" {
  source          = "path/to/module/iam-account-alias"
  account_alias   = "woffenden-cloud"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|:---:|:---:|:---:|:---:|:---:|
| name | Account alias [(resource documentation)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias#account_alias) | string | n/a | yes |
