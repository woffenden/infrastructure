resource "github_team" "observability_platform" {
  name                      = "observability-platform"
  description               = "Observability Platform"
  privacy                   = "closed"
  create_default_maintainer = true
}

resource "github_team_membership" "jacobwoffenden_observability_platform" {
  team_id  = github_team.observability_platform.id
  username = "jacobwoffenden"
  role     = "member"
}

resource "github_team_repository" "observability_platform" {
  team_id    = github_team.observability_platform.id
  repository = "infrastructure"
  permission = "push"
}
