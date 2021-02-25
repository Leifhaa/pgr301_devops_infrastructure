variable "logz_token" {
  description = "API token used for shipping logs to logz.io"
  type = string
  #Empty variable which will be submitted by the container's enviroment variable
  #Terraform.apply will fail if this is not set
}

variable "logz_url" {
  description = "The URI target for shipping logs to logz.io"
  type = string
  #Empty variable which will be submitted by the container's enviroment variable
  #Terraform.apply will fail if this is not set
}

variable "statuscake_key" {
  description = "API key for configuration & setup on statuscake.com"
  type = string

}

variable "project_id" {
  description = "The google project ID"
  type = string
  default = "exam-295817"
}

variable "aws_lambda_version" {
}