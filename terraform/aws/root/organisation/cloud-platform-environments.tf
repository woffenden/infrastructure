locals {
  cloud_platform_environments = fileset(path.module, "configuration/cloud-platform-environments/*.json")
}

module "cloud_platform_environments" {
  for_each = {
    for f in local.cloud_platform_environments : trimsuffix(basename(f), ".json") => f
  }

  source = "../../../modules/aws/organisation/modules/cloud-platform-environment"

  configuration = jsondecode(file("${path.module}/${each.value}"))
}
