output "lambda-dynamodb-role" {
  value = aws_iam_role.moloko-blog-lambda-role.id
}