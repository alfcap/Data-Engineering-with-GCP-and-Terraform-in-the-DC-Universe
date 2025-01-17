# Creation of buckets 
buckets = {
  "Batman_bucket" = {
    name          = "" # Name of the bucket
    location      = ""
    project       = "batman-projet-438510" # Name of the project 
    force_destroy = true
  }
  "Villains_bucket" = {
    name          = "list_of_villains_terraform_project_2025"
    location      = "EU"
    project       = "villains-project"
    force_destroy = true
  }  
}

# Objects to import in buckets
bucket_objects = {
  "content_folder" = {
    name         = "temp/"
    content      = "Not really a directory, but it's empty."
    bucket       = "Batman_bucket"
  }
  "Arkham_Json" = {
    name         = "arkham"
    source       = "replace_with_the_path_to_arkham_JSON" # Provide the local path to arkham.JSON
    content_type = "json"
    bucket       = "Batman_bucket"
  }
  "Jail_python" = {
    name   = "jail_villains"
    source = "replace_with_the_path_to_jail_villains_py" # Provide the local path to jail_villains.py
    bucket = "Batman_bucket"
  }
  "Joker" = {
    name         = "joker"
    source       = "replace_with_the_path_to_joker_txt" # Provide the local path to joker.txt
    content_type = "text/plain"
    bucket       = "Villains_bucket"
  }
  "Old_villains" = {
    name   = "old/"
    content      = "Not really a directory, but it's empty."
    bucket = "Villains_bucket"
  }
}

# List of service accounts
service_accounts = {
  batman      = { account_id = "batman-service-account", display_name = "Batman", project = "batman-projet-438510" }
  robin       = { account_id = "robin-service-account", display_name = "Robin", project = "batman-projet-438510" }
  alfred      = { account_id = "alfred-service-account", display_name = "Alfred", project = "batman-projet-438510" }
  superman    = { account_id = "superman-service-account", display_name = "Superman", project = "superman-projet" }
  lois        = { account_id = "lois-service-account", display_name = "Lois Lane", project = "superman-projet" }
  wonderwoman = { account_id = "wonderwoman-service-account", display_name = "WonderWoman", project = "wonderwoman-projet" }
  amazone     = { account_id = "amazone-service-account", display_name = "Amazone", project = "wonderwoman-projet" }
}

# IAM roles at the project level
project_iam_roles = {
  "batman_owner"               = { project = "batman-projet-438510", role = "roles/owner", service_account = "batman" }
  "batman_dataflow_admin"      = { project = "batman-projet-438510", role = "roles/dataflow.admin", service_account = "batman" }
  "batman_service_account_user" = { project = "batman-projet-438510", role = "roles/iam.serviceAccountUser", service_account = "batman" }
  "batman_composer_worker" = { project = "batman-projet-438510", role = "roles/composer.worker", service_account = "batman" } 
}

# IAM permissions at the dataset level for BigQuery
dataset_iam_roles = {
  "batman_editor_batcave"                = { project = "batman-projet-438510", dataset_id = "Batcave", role = "roles/bigquery.dataEditor", service_account = "batman" }
  "robin_view_batcave"                   = { project = "batman-projet-438510", dataset_id = "Batcave", role = "roles/bigquery.dataViewer", service_account = "robin" }
  "alfred_view_batcave"                  = { project = "batman-projet-438510", dataset_id = "Batcave", role = "roles/bigquery.dataViewer", service_account = "alfred" }
  "superman_viewer_superman_appartment"  = { project = "superman-projet", dataset_id = "Superman_flat", role = "roles/bigquery.dataViewer", service_account = "superman" }
  "lois_editor_superman_apartment"       = { project = "superman-projet", dataset_id = "Superman_flat", role = "roles/bigquery.dataEditor", service_account = "lois" }
  "wonderwoman_editor_themyscira"        = { project = "wonderwoman-projet", dataset_id = "Themyscira", role = "roles/bigquery.dataEditor", service_account = "wonderwoman" }
  "amazone_view_themyscira"              = { project = "wonderwoman-projet", dataset_id = "Themyscira", role = "roles/bigquery.dataViewer", service_account = "amazone" }
}

# IAM permissions at the table level for BigQuery
table_iam_roles = {
  "batman_editor_superman_table"       = { project = "superman-projet", dataset_id = "Superman_flat", table_id = "Superman_equipments", role = "roles/bigquery.dataEditor", service_account = "batman" }
  "alfred_editor_robin_table"          = { project = "batman-projet-438510", dataset_id = "Batcave", table_id = "Robin_equipments", role = "roles/bigquery.dataEditor", service_account = "alfred" }
  "alfred_editor_alfred_table"         = { project = "batman-projet-438510", dataset_id = "Batcave", table_id = "Alfred_equipments", role = "roles/bigquery.dataEditor", service_account = "alfred" }
  "robin_editor_robin_table"           = { project = "batman-projet-438510", dataset_id = "Batcave", table_id = "Robin_equipments", role = "roles/bigquery.dataEditor", service_account = "robin" }
  "superman_editor_superman_equipment" = { project = "superman-projet", dataset_id = "Superman_flat", table_id = "Superman_equipments", role = "roles/bigquery.dataEditor", service_account = "superman" }
  "amazone_editor_amazone_table"       = { project = "wonderwoman-projet", dataset_id = "Themyscira", table_id = "Amazone_equipments", role = "roles/bigquery.dataEditor", service_account = "amazone" }
}

# IAM permissions at the bucket level for Storage
bucket_iam_roles = {
  "batman_viewer_own_bucket"     = { bucket = "gcs_of_batman_for_terraform_project_2025", role = "roles/storage.objectViewer", service_account = "batman" }
  "batman_admin_own_bucket"      = { bucket = "gcs_of_batman_for_terraform_project_2025", role = "roles/storage.objectAdmin", service_account = "batman" }
  "batman_viewer_villains_bucket" = { bucket = "list_of_villains_terraform_project_2025", role = "roles/storage.objectUser", service_account = "batman" }
}
