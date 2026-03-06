# Configuration Terraform pour infrastructure LOCALE
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "registry.opentofu.org/kreuzwerker/docker"
      version = "~> 3.9"
    }
  }
}
