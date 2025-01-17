resource "google_service_account" "service_account" {
  for_each    = var.service_accounts  # Creation of all service account with iteration

  account_id   = each.value.account_id
  display_name = each.value.display_name
  project      = each.value.project
}

# Right at the project level 
resource "google_project_iam_member" "project_iam" {
  for_each = var.project_iam_roles
  project  = each.value.project
  role     = each.value.role
  member   = "serviceAccount:${var.service_accounts[each.value.service_account].account_id}@${var.service_accounts[each.value.service_account].project}.iam.gserviceaccount.com"
  depends_on = [google_service_account.service_account]  
}

# Right at the BigQuery dataset level 
resource "google_bigquery_dataset_iam_member" "dataset_iam" {
  for_each   = var.dataset_iam_roles
  project    = each.value.project
  dataset_id = each.value.dataset_id
  role       = each.value.role
  member     = "serviceAccount:${var.service_accounts[each.value.service_account].account_id}@${var.service_accounts[each.value.service_account].project}.iam.gserviceaccount.com"
  depends_on = [google_service_account.service_account]  
}

# Right at the BigQuery table level 
resource "google_bigquery_table_iam_member" "table_iam" {
  for_each   = var.table_iam_roles
  project    = each.value.project
  dataset_id = each.value.dataset_id
  table_id   = each.value.table_id
  role       = each.value.role
  member     = "serviceAccount:${var.service_accounts[each.value.service_account].account_id}@${var.service_accounts[each.value.service_account].project}.iam.gserviceaccount.com"
  depends_on = [google_service_account.service_account]  
}

# Right at the GCS bucket level 
resource "google_storage_bucket_iam_member" "bucket_iam" {
  for_each = var.bucket_iam_roles
  bucket   = each.value.bucket
  role     = each.value.role
  member   = "serviceAccount:${var.service_accounts[each.value.service_account].account_id}@${var.service_accounts[each.value.service_account].project}.iam.gserviceaccount.com"
  depends_on = [google_service_account.service_account]  
}