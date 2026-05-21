variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "log_group_name" {
  description = "Name of the CloudWatch Log Group"
  type        = string
  default     = "/terraform-sandbox/demo-log-group"
}

variable "log_retention_in_days" {
  description = "Number of days to retain logs"
  type        = number
  default     = 14
  validation {
    condition     = var.log_retention_in_days >= 0
    error_message = "Retention period must be a non-negative integer."
  }
}

variable "tags" {
  description = "Tags applied to created resources"
  type        = map(string)
  default = {
    Project     = "terraform-sandbox"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

# ── Lambda ────────────────────────────────────────────────────────────────────

variable "lambda_function_name" {
  description = "Name of the Hello World Lambda function"
  type        = string
  default     = "hello-world"
}

variable "lambda_source_dir" {
  description = "Path to the Lambda source code directory (relative to the project root)"
  type        = string
  default     = "./lambdas/hello_world"
}

variable "lambda_handler" {
  description = "Lambda handler in the format file.method"
  type        = string
  default     = "handler.lambda_handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime identifier"
  type        = string
  default     = "python3.12"
}

# ── API Gateway ───────────────────────────────────────────────────────────────

variable "api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
  default     = "hello-world-api"
}

variable "api_path_part" {
  description = "URL path segment for the GET endpoint (e.g. 'hello' → /{stage}/hello)"
  type        = string
  default     = "hello"
}

variable "api_stage_name" {
  description = "Name of the API Gateway deployment stage"
  type        = string
  default     = "dev"
}