resource "aws_lambda_function" "Lokos-blok-crud-function" {
  s3_bucket     = "moloko-lambda-functions"
  s3_key        = "Lokos-Blok/molokos-blog-crud.zip"
  function_name = "Lokos-blok-crud-function"
  role          = var.lambda-role-arn
  handler       = "molokos-blog-crud.lambda_handler"

  runtime = "python3.12"

  environment {
    variables = {
      Name        = "${var.project_name}-Lambda Function"
      Environment = "production"
      Costs       = "${var.project_name}"
    }
  }
}