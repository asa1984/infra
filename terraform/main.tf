terraform {
  required_providers {
    cloudflare = {
      source = "registry.opentofu.org/cloudflare/cloudflare"
    }
    github = {
      source = "registry.opentofu.org/integrations/github"
    }
    vultr = {
      source = "registry.opentofu.org/vultr/vultr"
    }
  }
}

# GitHub

locals {
  github = {
    owner = "asa1984"
  }
}

variable "terraform_github_app_id" {
  description = "GitHub App ID used for Terraform automation"
  type        = string
  sensitive   = true
}

variable "terraform_github_app_installation_id" {
  description = "GitHub App Installation ID used for Terraform automation"
  type        = string
  sensitive   = true
}

variable "terraform_github_app_pem_file" {
  description = "GitHub App private key used for Terraform automation"
  type        = string
  sensitive   = true
}


provider "github" {
  owner = local.github.owner
  app_auth {
    id              = var.terraform_github_app_id
    installation_id = var.terraform_github_app_installation_id
    pem_file        = var.terraform_github_app_pem_file
  }
}
