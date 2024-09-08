terraform {
  backend "local" {
    path = "data/terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-2"

  default_tags {
    tags = {
      "IaC"         = "Terraform"
      "Region"      = "Seoul"
      "AccountName" = "test-projetc"
    }
  }
}

data "aws_caller_identity" "current" {}

module "power_usage_data_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "power-usage-data-bucket"
}

module "power_usage_query_result_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "power-usage-query-result-bucket"
}

