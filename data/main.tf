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

locals {
  data_source_bucket_name = "power-usage-data-bucket"
}

data "aws_caller_identity" "current" {}

# data source bucket
data "aws_iam_policy_document" "data_source_bucket_policy" {
  statement {
    sid       = "AllowS3ActionsForQuickSight"
    effect    = "Allow"
    principals {
      type        = "Service"
      identifiers = ["quicksight.amazonaws.com"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${local.data_source_bucket_name}",
      "arn:aws:s3:::${local.data_source_bucket_name}/*",
    ]
  }
}

module "power_usage_data_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = local.data_source_bucket_name

  attach_policy = true
  policy        = data.aws_iam_policy_document.data_source_bucket_policy.json
  force_destroy = true

  versioning = {
    enabled = true
  }
}


