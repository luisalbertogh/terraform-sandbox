aws_region            = "eu-central-1"
log_group_name        = "/terraform-sandbox/demo-log-group"
log_retention_in_days = 14
bucket_name           = "my-unique-s3-bucket"

# Lambda
lambda_function_name = "hello-world"
lambda_source_dir    = "./lambdas/hello_world"
lambda_handler       = "handler.lambda_handler"
lambda_runtime       = "python3.12"

# API Gateway
api_name       = "hello-world-api"
api_path_part  = "hello"
api_stage_name = "dev"

tags = {
  Project     = "terraform-sandbox"
  Environment = "dev"
  ManagedBy   = "terraform"
}
