terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 4.0"     # https://github.com/cloudposse/terraform-aws-tfstate-backend/issues/111
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "terraform_state_backend" {
  source     = "cloudposse/tfstate-backend/aws"
  version    = "0.38.1"
  namespace  = "jo"
  stage      = "personal"
  name       = "terraform"
  attributes = ["state"]
}
