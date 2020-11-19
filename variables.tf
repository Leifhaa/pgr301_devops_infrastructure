variable "logz_token" {
  #Empty variable which will be submitted by the container's enviroment variable
  #Terraform.apply will fail if this is not set
}

variable "logz_url" {
  #Empty variable which will be submitted by the container's enviroment variable
  #Terraform.apply will fail if this is not set
}

variable "project_id" {
  default = "exam-295817"
}