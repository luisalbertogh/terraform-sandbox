provider "aws" {
  region  = var.aws_region
  profile = "default"
} 

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
