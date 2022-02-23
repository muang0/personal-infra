terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "jo-personal-terraform-state"
    key            = "s3-static-website/terraform.tfstate"
    dynamodb_table = "jo-personal-terraform-state-lock"
    profile        = "default"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
  alias   = "main"
}

module "s3-static-website" {
  source  = "cn-terraform/s3-static-website/aws"
  version = "0.0.10"
  providers = {
    aws.main         = aws.main
    aws.acm_provider = aws.main
  }
  name_prefix                            = "personal-static-site"
  cloudfront_default_root_object         = "resume.html"
  create_route53_hosted_zone             = false
  log_bucket_versioning_status           = "Suspended"
  www_website_versioning_enabled         = false
  website_domain_name                    = "static.jamesdevsite.com"
  route53_hosted_zone_id                 = "Z07116792218IJE7N64FH"
  aws_accounts_with_read_view_log_bucket = ["800610060907"]
  tags = {
    "app" : "s3-static-website"
  }
}
