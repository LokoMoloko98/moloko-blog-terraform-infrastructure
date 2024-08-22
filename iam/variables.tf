# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "dynamodb-arn" {
  type = string
}

variable "lambda_bucket" {
  type = string
}