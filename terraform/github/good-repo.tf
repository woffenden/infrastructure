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


resource "github_repository_dependabot_security_updates" "good_repo" {
  repository = github_repository.good_repo.name
  enabled    = true
}

resource "github_repository_ruleset" "good_repo" {
  name        = "main"
  repository  = github_repository.good_repo.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      exclude = []
      include = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    creation                      = false # Required
    deletion                      = false # Required
    non_fast_forward              = false # Required
    required_linear_history       = true  # Required
    required_signatures           = true  # Required
    update                        = false # Required
    update_allows_fetch_and_merge = false # Required

    pull_request {
      dismiss_stale_reviews_on_push     = true # Required
      require_code_owner_review         = true # Required
      require_last_push_approval        = true # Required
      required_approving_review_count   = 1    # Required
      required_review_thread_resolution = true # Required
    }

    # required_deployments {}

    required_status_checks {
      do_not_enforce_on_create = true # Required
      # These checks are come from the GitHub Actions workflows
      required_check {
        context        = "CodeQL"
        integration_id = "57789" # CodeQL Analysis
      }
      required_check {
        context        = "Dependency Review"
        integration_id = "15368" # GitHub Actions
      }
      required_check {
        context        = "Super Linter"
        integration_id = "15368" # GitHub Actions
      }
    }

    /*
    # This does not work properly, it continously tries to create the rule.
    required_code_scanning {
      required_code_scanning_tool {
        tool                      = "CodeQL"         # Required
        alerts_threshold          = "errors"         # Required
        security_alerts_threshold = "high_or_higher" # Required
      }
    }
    */
  }
}

import {
  to = github_repository_ruleset.good_repo
  id = "good-repo:5666891"
}
