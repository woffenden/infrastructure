resource "github_team" "container_platform" {
  name                      = "container-platform"
  description               = "Container Platform"
  privacy                   = "closed"
  create_default_maintainer = true
}

resource "github_team_membership" "jacobwoffenden_container_platform" {
  team_id  = github_team.container_platform.id
  username = "jacobwoffenden"
  role     = "member"
}

resource "github_team_repository" "container_platform" {
  team_id    = github_team.container_platform.id
  repository = "infrastructure"
  permission = "push"
}
