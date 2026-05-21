mock_provider "aws" {}

run "api_gateway_uses_expected_inputs" {
  command = plan

  variables {
    api_name             = "test-api"
    lambda_invoke_arn    = "arn:aws:apigateway:eu-west-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:123456789012:function:test/invocations"
    lambda_function_name = "test-lambda"
    tags = {
      Environment = "test"
      ManagedBy   = "terraform-test"
    }
  }

  assert {
    condition     = aws_api_gateway_rest_api.this.name == "test-api"
    error_message = "El nombre del API no coincide con el valor esperado."
  }

  assert {
    condition     = aws_api_gateway_method.this.http_method == "GET"
    error_message = "El método HTTP debe ser GET."
  }

  assert {
    condition     = aws_api_gateway_method.this.authorization == "NONE"
    error_message = "La autorización debe ser NONE."
  }

  assert {
    condition     = aws_api_gateway_integration.this.type == "AWS_PROXY"
    error_message = "El tipo de integración debe ser AWS_PROXY."
  }

  assert {
    condition     = aws_api_gateway_resource.this.path_part == "hello"
    error_message = "El path_part debe ser 'hello' por defecto."
  }

  assert {
    condition     = aws_api_gateway_stage.this.stage_name == "dev"
    error_message = "El nombre del stage debe ser 'dev' por defecto."
  }

  assert {
    condition     = aws_lambda_permission.this.principal == "apigateway.amazonaws.com"
    error_message = "El principal del permiso Lambda debe ser apigateway.amazonaws.com."
  }
}
