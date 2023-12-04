terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.6"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

