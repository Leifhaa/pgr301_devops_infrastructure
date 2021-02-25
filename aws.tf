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

#Configure an API gateway
resource "aws_api_gateway_rest_api" "example" {
  name        = "ServerlessExample"
  description = "Terraform Serverless Application Example"
}

#All incomign requests to API gateway must match with configured resource and method in order to be handled.
#{proxy+} will mean that resource will match any request
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "{proxy+}"
}

#Allow any HTTP request method to be used
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

#Specify where incoming requests are routed. Specifying that requests to this method should be sent to our lambda function
#AWS_PROXY will make API gateway call into our AWS Lambda
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.aws-lambda-executor.invoke_arn
}

#The proxy resource cannot match an empty oath at the root of the API. to handle such, a similar configuration
#must be applied to the root resource that is built in to the rest API object
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_rest_api.example.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.aws-lambda-executor.invoke_arn
}

#Create anAPI gateway in order to activate our configuration and expose the API atan URL that can be used for testing.
resource "aws_api_gateway_deployment" "example" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = "test"
}

#By default, two AWS services cannot access each other until accessis granted.
#Allow API gateway to access lambda
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws-lambda-executor.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
}

##Collect the test URL in output log
output "base_url" {
  value = aws_api_gateway_deployment.example.invoke_url
}