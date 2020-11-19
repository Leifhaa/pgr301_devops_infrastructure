#Google is announced as a provider -> terraform recognizes this resource as google's.
#Creates a new google_cloud_run_service service if not exist
resource "google_cloud_run_service" "taskapp" {
  name     = "taskapp"
  location = "europe-north1"

  template {
    spec {
      containers {
        #Change latest to another image ID for running another build.
        image = "gcr.io/exam-295817/helloworld:latest"
        env{
          #Set terraform variables from environment variables
          #(We're making travis give the environment variable to terraform, so terraform can set it in google cloud run)
          name = "LOGZ_TOKEN"
          value = var.logz_token
        }
        env {
          name = "LOGZ_URL"
          value = var.logz_url
        }
      }
    }
  }
}

data "google_iam_policy" "taskapp_noauth" {
  binding{
    #Role - which roles has access, run - specified being cloud run service, invoker - Priveledged to access via URL
    role = "roles/run.invoker"
    members = [
      #All users allowed as 'run.invoker"
      "allUsers",
    ]
  }
}

##bind the 'data' policy to a service
resource "google_cloud_run_service_iam_policy" "taskapp_noauth"{
  location = google_cloud_run_service.taskapp.location
  project = google_cloud_run_service.taskapp.project
  service = google_cloud_run_service.taskapp.name

  policy_data = data.google_iam_policy.taskapp_noauth.policy_data
}


