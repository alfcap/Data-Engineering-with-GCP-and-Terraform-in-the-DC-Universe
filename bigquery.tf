resource "google_bigquery_dataset" "datasets" {
  for_each = local.datasetsMap

  project    = each.value["project"]
  dataset_id    = each.value["datasetId"]
  friendly_name = each.value["datasetFriendlyName"]
  description   = each.value["datasetDescription"]
  location      = each.value["datasetRegion"]
}

resource "google_bigquery_table" "tables" {
  for_each = {for idx, table in local.tables_flattened : "${table["datasetId"]}_${table["tableId"]}" => table}

  project    = each.value["project"]
  dataset_id = each.value["datasetId"]
  table_id   = each.value["tableId"]
  deletion_protection=false
  schema = file("${each.value["tableSchemaPath"]}")

  depends_on = [google_bigquery_dataset.datasets]
}

