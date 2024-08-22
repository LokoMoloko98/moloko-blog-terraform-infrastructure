resource "aws_codebuild_project" "lambda_codebuild" {
  name          = "lambda-functions-build"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 5

  source {
    type            = "GITHUB"
    location        = "https://github.com/LokoMoloko98/mea-munera-lambda.git"
    git_clone_depth = 1
    buildspec       = <<-EOF
        version: 0.2

        phases:
        install:
            commands:
            - pip install -r requirements.txt
        build:
            commands:
            - zip -r function.zip .
        post_build:
            commands:
            - aws s3 cp function.zip s3://${aws_s3_bucket.lambda_bucket.bucket}/lambda/
            - aws lambda update-function-code --function-name your-lambda-function-name --s3-bucket ${aws_s3_bucket.lambda_bucket.bucket} --s3-key lambda/function.zip

        EOF
  }
  
  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"
  }
}


resource "aws_codebuild_source_credential" "example" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = "example"
}
