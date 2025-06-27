provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../modules/vpc"
  name             = "harness-iacm-vpc"
  vpc_cidr         = "10.0.0.0/16"
  environment      = "dev"
  cost_center      = "INF"
  tag_owner        = "nikp"
  project          = "SE"
}
