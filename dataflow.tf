
provider "google-beta" {
  project = var.project
  credentials = file("C:\\Path\\to\\the\\key\\of\\the\\Service\\account.json")
}
variable "project" {
  default = "batman-projet-438510"
}
variable "region" {
  default = "europe-west9"
}

resource "google_dataflow_flex_template_job" "dataflowjob" {
  provider          = google-beta
  container_spec_gcs_path = "gs://dataflow-templates-${var.region}/latest/flex/GCS_Text_to_BigQuery_Xlang"
  name              = "jail-the-villains"
  region            = var.region
  max_workers = 1
  on_delete = "cancel"
  service_account_email = "batman-service-account@batman-projet-438510.iam.gserviceaccount.com"  
  parameters        = {
    inputFilePattern = "gs://list_of_villains_terraform_project_2025/joker"
    JSONPath = "gs://gcs_of_batman_for_terraform_project_2025/arkham"
    outputTable = "batman-projet-438510:Batcave.Arkham Asylum"
    bigQueryLoadingTemporaryDirectory = "gs://gcs_of_batman_for_terraform_project_2025/temp/"
    pythonExternalTextTransformGcsPath = "gs://gcs_of_batman_for_terraform_project_2025/jail_villains"
    pythonExternalTextTransformFunctionName = "transform_villain"
  }
}
