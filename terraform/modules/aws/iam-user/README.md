# iam-group

This Terraform module creates an AWS IAM user

## Usage

```hcl
module "user_jacobwoffenden" {
  source        = "path/to/module/iam-user"
  enabled       = true
  full_name     = "Jacob Woffenden"
  email_address = "jacob@woffenden.io"
  groups = [
    module.group_all_users.name
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|:---:|:---:|:---:|:---:|:---:|
| enabled | Enables or disables the user | bool | `true` | no |
| full_name | User's full name | string | n/a | yes |
| email_address | User's email address | string | n/a | yes |
| groups | List of groups for user to be added to [(resource documentation)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership#groups) | list | n/a | yes |
| path | Path in which to create the group [(resource documentation)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group#path) | string | `/` | no |
