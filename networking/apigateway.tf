resource "aws_apigatewayv2_api" "moloko-blog-api-gateway" {
  name          = "${var.project_name}-http-api"
  description   = "Loko Blok's API_gateway"
  protocol_type = "HTTP"

}

resource "aws_apigatewayv2_integration" "moloko-blog-apigateway-lambda-integration" {
  api_id           = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  integration_type = "AWS_PROXY"

  connection_type      = "INTERNET"
  description          = "Loko Blok's API_gateway-Lambda integration"
  integration_uri      = var.lambda-function-arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_stage" "moloko-blog-api-gateway-production-stage" {
  api_id        = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  name          = "v1"
  deployment_id = aws_apigatewayv2_deployment.moloko-blog-apigateway-prd-deployment.id
}


resource "aws_apigatewayv2_deployment" "moloko-blog-apigateway-prd-deployment" {
  api_id      = aws_apigatewayv2_api.moloko-blog-api-gateway.id
  description = "Loko's Blok deployment policy"

  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.moloko-blog-apigateway-lambda-integration),
      jsonencode(aws_apigatewayv2_route.create-blog),
      jsonencode(aws_apigatewayv2_route.get-a-blog),
      jsonencode(aws_apigatewayv2_route.get-all-blogs),
      jsonencode(aws_apigatewayv2_route.delete-blog)
    ])))
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_ssm_parameter" "route_53_hostzone_id" {
  name            = "route_53_hostzone_id"
  with_decryption = true
}
