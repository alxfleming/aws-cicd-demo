resource "aws_api_gateway_rest_api" "aws_cicd_demo_rest_api" {
  name        = "aws-cicd-demo-rest-api"
  description = "CI/CD Demo Rest API"
}

resource "aws_api_gateway_resource" "hello" {
  parent_id   = aws_api_gateway_rest_api.aws_cicd_demo_rest_api.root_resource_id
  path_part   = "hello"
  rest_api_id = aws_api_gateway_rest_api.aws_cicd_demo_rest_api.id
}

resource "aws_api_gateway_method" "hello_get" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.hello.id
  rest_api_id   = aws_api_gateway_rest_api.aws_cicd_demo_rest_api.id
}

resource "aws_api_gateway_integration" "hello_get" {
  http_method             = aws_api_gateway_method.hello_get.http_method
  resource_id             = aws_api_gateway_resource.hello.id
  rest_api_id             = aws_api_gateway_rest_api.aws_cicd_demo_rest_api.id
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.say_hello.invoke_arn
}

resource "aws_api_gateway_deployment" "dev" {
  depends_on  = [aws_api_gateway_integration.hello_get]
  rest_api_id = aws_api_gateway_rest_api.aws_cicd_demo_rest_api.id
  stage_name  = "dev"
}

output "base_url" {
  value = aws_api_gateway_deployment.dev.invoke_url
}