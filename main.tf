terraform {
  backend "remote" {
    organization = "skcc70491"
    workspaces {
      name = "tfc-aws-architecture"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  region = var.region
}