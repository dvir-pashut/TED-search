terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = "dvir-state"
    key    = "ted-search/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = var.region
}

provider "local" {
  # Configuration options
}

provider "null" {
  # Configuration options
}