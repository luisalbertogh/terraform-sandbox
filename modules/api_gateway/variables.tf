variable "api_name" {
  description = "Name of the API Gateway REST API"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway REST API"
  type        = string
  default     = ""
}

variable "path_part" {
  description = "URL path segment for the API resource (e.g. 'hello' creates /{stage}/hello)"
  type        = string
  default     = "hello"
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function to integrate with (use module.lambda.invoke_arn)"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to grant API Gateway permission to invoke"
  type        = string
}

variable "stage_name" {
  description = "Name of the API Gateway deployment stage"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
  default     = {}
}
