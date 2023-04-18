terraform {
  # Required Terraform Version
  required_version = "~> 1.0"
  # Required Providers and their Versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21" # Optional but recommended
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
