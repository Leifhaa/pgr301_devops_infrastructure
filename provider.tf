terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    statuscake = {
      source= "terraform-providers/statuscake"
    }
    aws = {
      source="hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  #Save the terraform state (backend) to google cloud storage (gcs)
  backend "gcs" {
    bucket = "exam-295817-tf-state"
    prefix = "terraformstate"
    credentials = "terraform_keyfile.json"
  }
}


provider "aws" {
  profile = "default"
  region = "us-east-1"
}

#A provider is used to configure the named provider. A provider is responsible for creating resources
#multiple provider blocks can exist if Terraform configuration manages resources from different providers
provider "google" {
  version = "3.5.0"
  credentials = file("terraform_keyfile.json")
  project     = "exam-295817"
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "statuscake" {
  username = "Leifhaahotmailcom"
  #API key will be set through the env variable: STATUSCAKE_APIKEY
}