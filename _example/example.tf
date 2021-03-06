provider "aws" {
  region = "eu-west-1"
}

module "s3_bucket" {
  source  = "clouddrove/s3/aws"
  version = "0.13.0"

  name        = "log-bucket"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "application", "name"]



  versioning     = true
  acl            = "private"
  bucket_enabled = true
}

module "vpc" {
  source = "../"

  name        = "vpc"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "application", "name"]

  cidr_block = "10.0.0.0/16"

  enable_flow_log = true
  s3_bucket_arn   = module.s3_bucket.arn
}