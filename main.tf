terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

# This module creates a CloudWatch Log Group in AWS.
module "log_group" {
  source = "./modules/log_group"

  name              = var.log_group_name
  retention_in_days = var.log_retention_in_days
  tags              = var.tags
}

module "s3_bucket" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}

# Lambda function that returns a Hello World JSON response
module "hello_world_lambda" {
  source = "./modules/lambda"

  function_name = var.lambda_function_name
  source_dir    = var.lambda_source_dir
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  tags          = var.tags
}

# API Gateway REST API with a GET /{path_part} → Lambda integration
module "hello_world_api" {
  source = "./modules/api_gateway"

  api_name             = var.api_name
  path_part            = var.api_path_part
  stage_name           = var.api_stage_name
  lambda_invoke_arn    = module.hello_world_lambda.invoke_arn
  lambda_function_name = module.hello_world_lambda.function_name
  tags                 = var.tags
}