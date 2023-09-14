locals {
  name  = var.configuration.name
  email = "${var.configuration.name}@woffenden.io"
  environments = var.configuration.environments
}
