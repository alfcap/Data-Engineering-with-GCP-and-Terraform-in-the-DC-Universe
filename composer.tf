resource "google_service_account_iam_member" "custom_service_account" {
  provider = google  
  service_account_id = google_service_account.service_account["batman"].name
  role = "roles/composer.ServiceAgentV2Ext"
  member = "serviceAccount:service-1019959241275@cloudcomposer-accounts.iam.gserviceaccount.com"
}

resource "google_composer_environment" "example_environment" {
  provider = google
  name = "example-environment"
  project  = "batman-projet-438510"

  config {

    software_config {
      image_version = "composer-2.10.1-airflow-2.10.2"
    }

    node_config {
      service_account = google_service_account.service_account["batman"].email
    }

  }
}
