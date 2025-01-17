provider "google" {
  project     = "Folder-projet"
  region      = "us-central1"
  credentials = file("C:\\Path\\to\\the\\key\\of\\the\\Service\\account.json")
}
