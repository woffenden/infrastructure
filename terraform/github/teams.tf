module "cloud_platform_team" {
  source = "../modules/github/team"

  name        = "cloud-platform"
  description = "Cloud Platform Team"
  members     = ["jacobwoffenden"]
}

module "container_platform_team" {
  source = "../modules/github/team"

  name        = "container-platform"
  description = "Container Platform Team"
  members     = ["jacobwoffenden"]
}

module "observability_platform_team" {
  source = "../modules/github/team"

  name        = "observability-platform"
  description = "Observability Platform Team"
  members     = ["jacobwoffenden"]
}
