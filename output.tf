output "log_group_name" {
  description = "Name of the created CloudWatch Log Group"
  value       = module.log_group.name
}

output "log_group_arn" {
  description = "ARN of the created CloudWatch Log Group"
  value       = module.log_group.arn
}

output "lambda_function_name" {
  description = "Name of the Hello World Lambda function"
  value       = module.hello_world_lambda.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Hello World Lambda function"
  value       = module.hello_world_lambda.function_arn
}

output "api_invoke_url" {
  description = "Full URL to invoke the Hello World endpoint (HTTP GET)"
  value       = module.hello_world_api.invoke_url
}
