#Creation of the buckets
variable "buckets" {
  description = "Configuration of Google Cloud Storage buckets"
  type = map(object({
    name          = string
    location      = string
    project       = string
    force_destroy = bool
  }))
} 

#Import objects in the buckets
variable "bucket_objects" {
  description = "Configuration of objects to create in Google Storage buckets"
  type = map(object({
    name         = string
    content      = optional(string)
    source       = optional(string)
    content_type = optional(string)
    bucket       = string
  }))
}


#Creation of service accounts
variable "service_accounts" {
  description = "List of the service account to create, the name to display and in which project to create them"
  type = map(object({
    account_id   = string
    display_name = string
    project      = string
  }))
}

# Right at the project level
variable "project_iam_roles" {
  description = "List of the IAM role for each prochet and service account"
  type = map(object({
    project         = string
    role            = string
    service_account = string
  }))
}

# Permissions au niveau des datasets BigQuery
variable "dataset_iam_roles" {
  description = "Liste des rôles IAM pour chaque dataset et compte de service"
  type = map(object({
    project         = string
    dataset_id      = string
    role            = string
    service_account = string
  }))
}

# Permissions au niveau des tables BigQuery
variable "table_iam_roles" {
  description = "Liste des rôles IAM pour chaque table et compte de service"
  type = map(object({
    project         = string
    dataset_id      = string
    table_id        = string
    role            = string
    service_account = string
  }))
}

# Permissions au niveau des buckets Google Storage
variable "bucket_iam_roles" {
  description = "Liste des rôles IAM pour chaque bucket et compte de service"
  type = map(object({
    bucket          = string
    role            = string
    service_account = string
  }))
}

