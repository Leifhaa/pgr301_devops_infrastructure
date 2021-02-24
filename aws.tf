resource "aws_s3_bucket" "bucket_for_lambda" {
  bucket = "aws-lambda-bucket-leifhaa"
  acl    = "private"

  tags = {
    Name        = "Bucket for storing aws lambda function"
    Environment = "Dev"
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_lambda_function" "aws-lambda-executor" {
  function_name = "task-runner"
  role          = aws_iam_role.iam_for_lambda.arn

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "main.handler"
  runtime = "nodejs12.x"

  s3_bucket = "aws-lambda-bucket-leifhaa"
  s3_key    = "v1.0.0/taskrunner.zip"

}