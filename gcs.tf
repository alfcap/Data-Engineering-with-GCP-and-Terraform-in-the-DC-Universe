resource "google_storage_bucket" "bucket" {
  for_each      = var.buckets
  name          = each.value.name
  location      = each.value.location
  force_destroy = each.value.force_destroy
  project       = each.value.project
}

resource "google_storage_bucket_object" "bucket_object" {
  for_each     = var.bucket_objects
  name         = each.value.name
  content      = lookup(each.value, "content", null)
  source       = lookup(each.value, "source", null)
  content_type = lookup(each.value, "content_type", null)
  bucket       = google_storage_bucket.bucket[each.value.bucket].id
}

