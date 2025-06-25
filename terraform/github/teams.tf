module "cloud_platform_team" {
  source = "../modules/github/team"

  name        = "cloud-platform"
  description = "Cloud Platform Team"
  maintainers = ["jacobwoffenden"]
  members     = []
}
