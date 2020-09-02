terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "aws-cicd-demo-terraform-backend"
    key    = "terraform/aws-cicd-demo/terraform.tfstate"
    region = "eu-west-1"
    access_key = "${AWS_ACCESS_KEY_ID}"
    secret_key = "${AWS_SECRET_ACCESS_KEY}"
  }
}

provider "aws" {
  region = "eu-west-1"
}