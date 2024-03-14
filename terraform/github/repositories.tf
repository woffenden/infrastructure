resource "github_repository" "infrastructure" {
  name = "infrastructure"

  allow_auto_merge            = true
  allow_update_branch         = true
  delete_branch_on_merge      = true
  has_downloads               = false
  has_issues                  = true
  has_projects                = true
  has_wiki                    = false
  homepage_url                = "https://woffenden.github.io/infrastructure/"
  merge_commit_message        = "PR_TITLE"
  merge_commit_title          = "MERGE_MESSAGE"
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "PR_TITLE"
  vulnerability_alerts        = true
  web_commit_signoff_required = true

  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
    }
  }
}
