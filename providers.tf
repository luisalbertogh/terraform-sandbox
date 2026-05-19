provider "aws" {
  region  = var.aws_region
  profile = "testing"
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
