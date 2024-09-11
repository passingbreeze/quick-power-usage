terraform {
  backend "local" {
    path = "services/terraform.tfstate"
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




