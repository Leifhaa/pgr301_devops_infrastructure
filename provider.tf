#Required so Terraform knows which provider to download from the Terraform registry.
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
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


#A privder is used to configure the named provider. A provider is responsible for creating resources
#multiple provider blocks can exist if Terraform configuration manages resources from different providers
provider "google" {
  credentials = file("terraform_keyfile.json")
  project     = "exam-295817"
  region      = "europe-north1-a"
  zone        = "europe-north1-a-N2"
  version = "3.5.0"
}