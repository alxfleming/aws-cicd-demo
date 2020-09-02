resource "aws_iam_role" "lambda_exec" {
  name               = "LambdaExec"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "say_hello" {
  function_name = "SayHello"
  handler       = "say-hello"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "go1.x"
  s3_bucket     = "aws-cicd-demo-lambdas"
  s3_key        = "say-hello/v${var.say_hello_version}/say-hello.zip"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.say_hello.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.aws_cicd_demo_rest_api.execution_arn}/*/*"
}

output "version" {
  value = var.say_hello_version
}