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

  backend "s3" {
    bucket = "tfstate"
    key    = "asa1984/infra/terraform"
    region = "auto"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
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
