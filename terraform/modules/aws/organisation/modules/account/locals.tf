locals {
  email_address_template = "aws+cloud-platform+{identifier}@woffenden.io"
  email                  = replace(local.email_address_template, "{identifier}", random_id.email_suffix.hex)
}
