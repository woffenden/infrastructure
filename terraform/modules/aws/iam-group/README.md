# iam-group

This Terraform module creates an AWS IAM group

## Usage

```hcl
module "group_all_users" {
  source = "path/to/module/iam-group"
  name   = "group-name"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|:---:|:---:|:---:|:---:|:---:|
| name | Name of IAM group [(resource documentation)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group#name) | string | n/a | yes |
| path | Path in which to create the group [(resource documentation)](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group#path) | string | `/` | no |
