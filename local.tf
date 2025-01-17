locals {
  datasetsArray    = jsondecode(file("datasets_and_tables.json"))
  datasetsMap      = {for idx, val in local.datasetsArray : idx => val}
  tables_flattened = flatten([
    for dataset in local.datasetsMap : [
      for table in dataset["tables"] : {
        project                = dataset["project"]
        datasetId              = dataset["datasetId"]
        tableId                = table["tableId"]
        tableSchemaPath        = table["tableSchemaPath"]
      }
    ]
  ])
}
