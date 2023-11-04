resource "github_team" "cloud_platform" {
  name        = "cloud-platform"
  description = "Cloud Platform"
  privacy     = "closed"
  create_default_maintainer = true
}

resource "github_team_membership" "jacobwoffenden_cloud_platform" {
  team_id  = github_team.cloud_platform.id
  username = "jacobwoffenden"
  role     = "member"
}
