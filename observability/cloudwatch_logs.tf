resource "aws_cloudwatch_log_group" "moloko-blog-lambda-logs" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 30
}
