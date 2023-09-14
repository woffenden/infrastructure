module "cloud_platform_environments" {
  for_each = {
    for f in fileset(path.module, "configuration/cloud-platform-environments/*.json") : trimsuffix(basename(f), ".json") => f
  }

  source = "../../../modules/aws/organisation/modules/cloud-platform-environment"

  configuration = jsondecode(file("${path.module}/${each.value}"))
}
