# asa1984/infra

locals {
  # Repository roleとactor_idの対応
  repository_role = {
    maintain = 2
    write    = 4
    admin    = 5
  }
}

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

  bypass_actors {
    actor_id    = local.repository_role.admin
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }

  rules {
    deletion = false

    required_status_checks {
      required_check {
        context = "terraform-plan"
      }
    }
  }
}
