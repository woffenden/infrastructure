locals {
  name_sanitised         = trimprefix(var.name, "cloud-platform-")
  email_address_template = "aws+cloud-platform+{identifier}@woffenden.io"
  email                  = replace(local.email_address_template, "{identifier}", local.name_sanitised)
}
