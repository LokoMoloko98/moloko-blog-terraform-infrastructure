resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
  name = "${var.project_name}-dynamodb-lambdapolicy"
  role = aws_iam_role.moloko-blog-lambda-role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["dynamodb:*"],
        "Resource" : "${var.dynamodb-arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy" "moloko-blog-codebuild-policy" {
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = [
           "${var.lambda_bucket}/*"
        ]
      },
      {
        Action = [
          "lambda:UpdateFunctionCode"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:lambda:*:*:function:*"
      },
      {
        Action = [
          "codecommit:GitPull",
          "codecommit:GetBranch",
          "codecommit:GetCommit"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}