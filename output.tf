output "log_group_name" {
  description = "Name of the created CloudWatch Log Group"
  value       = module.log_group.name
}

output "log_group_arn" {
  description = "ARN of the created CloudWatch Log Group"
  value       = module.log_group.arn
}

output "existing_apigateway_welcome_log_group_name" {
  description = "Name of the existing API Gateway CloudWatch Log Group"
  value       = data.aws_cloudwatch_log_group.apigateway_welcome.name
}

output "existing_apigateway_welcome_log_group_retention_in_days" {
  description = "Retention period in days of the existing API Gateway CloudWatch Log Group"
  value       = data.aws_cloudwatch_log_group.apigateway_welcome.retention_in_days
}

output "existing_apigateway_welcome_log_group_arn" {
  description = "ARN of the existing API Gateway CloudWatch Log Group"
  value       = data.aws_cloudwatch_log_group.apigateway_welcome.arn
}
