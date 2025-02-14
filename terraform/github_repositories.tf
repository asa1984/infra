# asa1984/infra

resource "github_repository" "infra" {
  name        = "infra"
  description = "INFRASTRUCTURE"
  visibility  = "public"

  allow_auto_merge       = true
  allow_merge_commit     = true
  allow_rebase_merge     = false
  allow_update_branch    = false
  delete_branch_on_merge = true

  has_discussions = false
  has_projects    = false
  has_wiki        = false
}

resource "github_repository_ruleset" "infra_main" {
  enforcement = "active"
  name        = "mainブランチの保護"
  repository  = github_repository.infra.name
  target      = "branch"

  conditions {
    ref_name {
      exclude = []
      include = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    deletion = false

    branch_name_pattern {
      operator = "starts_with"
      pattern  = "main"
    }

    pull_request {
      required_approving_review_count = 1
    }

    required_status_checks {
      required_check {
        context = "ci"
      }
    }
  }
}
