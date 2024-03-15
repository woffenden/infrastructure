resource "github_team" "this" {
  name           = var.name
  description    = join(" • ", [var.description, "This team is defined and managed in Terraform"])
  privacy        = var.privacy
  parent_team_id = try(var.parent_team_id, null)

  create_default_maintainer = true
}

resource "github_team_membership" "this" {
  for_each = toset(var.members)

  team_id  = github_team.this.id
  username = each.value
  role     = "member"
}
