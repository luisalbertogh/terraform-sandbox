output "api_id" {
  description = "ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_arn" {
  description = "ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.arn
}

output "execution_arn" {
  description = "Execution ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "invoke_url" {
  description = "Full URL to invoke the GET endpoint: {stage_url}/{path_part}"
  value       = "${aws_api_gateway_stage.this.invoke_url}/${var.path_part}"
}

output "stage_url" {
  description = "Base URL of the deployed stage"
  value       = aws_api_gateway_stage.this.invoke_url
}
