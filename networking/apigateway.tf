resource "aws_apigatewayv2_api" "moloko-blog-api-gateway" {
  name          = "${var.project_name}-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "moloko-blog-apigateway-lambda-integration" {
  api_id           = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Loko Blok's APIgateway-Lambda integration"
  integration_uri           = var.lambda-function-arn
  passthrough_behavior      = "WHEN_NO_MATCH"
}