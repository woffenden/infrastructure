locals {
  global_variables = read_terragrunt_config(find_in_parent_folders("globals.hcl"))
}

include {
  path = find_in_parent_folders()
}

inputs = {}
