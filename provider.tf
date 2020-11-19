terraform {
  #Save the terraform state (backend) to google cloud storage (gcs)
  backend "gcs" {
    bucket = "exam-295817-tf-state"
    prefix = "terraformstate"
    credentials = "terraform_keyfile.json"
  }
}


#A privder is used to configure the named provider. A provider is responsible for creating resources
#multiple provider blocks can exist if Terraform configuration manages resources from different providers
provider "google-beta" {
  credentials = file("terraform_keyfile.json")
  project     = "exam-295817"
  region      = "europe-north1-a"
  version = "~> 3.0.0-beta.1"
}