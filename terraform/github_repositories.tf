# asa1984/infra

data "github_repository" "infra" {
  full_name = "asa1984/infra"
}

resource "github_repository_ruleset" "infra_main" {
  enforcement = "active"
  name        = "mainブランチの保護"
  repository  = data.github_repository.infra.name
  target      = "branch"

  conditions {
    ref_name {
      exclude = []
      include = ["~DEFAULT_BRANCH"]
    }
  }

  rules {
    deletion = false

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
