resource "aws_lambda_function" "test_lambda" {
  function_name = "test_lambda"
  role = aws_iam_role.test_lambda_role.arn
  handler = "lambda_handler"
  runtime = "python3.9"
  filename = "lambda.zip"
}

resource "aws_iam_role" "test_lambda_role" {
  name = "test_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test_lambda_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.test_lambda_role.name
}

resource "aws_apigatewayv2_api" "test_api" {
  name = "test_api"
  description = "API for test task"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "test_stage" {
  api_id = aws_apigatewayv2_api.test_api.id
  name   = "test-stage"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "test_integration" {
  api_id = aws_apigatewayv2_api.test_api.id
  integration_type = "AWS_PROXY"
  integration_method = "POST"
  integration_uri = aws_lambda_function.test_lambda.invoke_arn
}

resource "aws_apigatewayv2_deployment" "test_deployment" {
  api_id = aws_apigatewayv2_api.test_api.id
  triggers = {
  redeployment = sha1(join(",", tolist([
    jsonencode(aws_apigatewayv2_integration.test_integration),
    jsonencode(aws_apigatewayv2_route.test_route),
  ])))
  }
}

resource "aws_apigatewayv2_route" "test_route" {
  api_id    = aws_apigatewayv2_api.test_api.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.test_integration.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.test_api.execution_arn}/*/*"
}

output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.test_stage.invoke_url
}