resource "github_repository" "good_repo" {
  name            = "good-repo"
  description     = "Proof of Concept of a good repository"  # Optional (but recommended)
  homepage_url    = "https://github.com/woffenden/good-repo" # Optional (but recommended)
  visibility      = "public"                                 # Preferred
  has_issues      = true                                     # Required
  has_discussions = false                                    # Preferred
  has_projects    = false                                    # Preferred
  has_wiki        = false                                    # Preferred
  is_template     = false                                    # Preferred

  allow_merge_commit = false # Preferred
  allow_squash_merge = true  # Preferred
  allow_rebase_merge = false # Preferred
  allow_auto_merge   = false # Preferred

  squash_merge_commit_title   = "PR_TITLE" # Preferred
  squash_merge_commit_message = "PR_BODY"  # Preferred

  /*
  # Commented out because squash merge is preferred.
  merge_commit_title   = "PR_TITLE" # Preferred
  merge_commit_message = "PR_BODY"  # Preferred
  */

  delete_branch_on_merge = true # Preferred

  web_commit_signoff_required = true # Preferred

  auto_init = true

  archived           = false # Preferred
  archive_on_destroy = true  # Preferred

  security_and_analysis {
    /* Advanced Security is always enabled for public repositories, so it does not need to be specified.
    advanced_security {
      status = "enabled" # Required
    }
    */
    secret_scanning {
      status = "enabled" # Required
    }
    secret_scanning_push_protection {
      status = "enabled" # Required
    }
  }

  topics = ["best-practice"] # Optional (but recommended)

  vulnerability_alerts = true # Required

  allow_update_branch = true # Optional

  lifecycle {
    ignore_changes = [
      has_downloads # Deprecated but appears in the plan
    ]
  }
}
