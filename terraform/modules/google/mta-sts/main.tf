resource "google_storage_bucket" "this" {
  name                        = local.gcs_bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = "true"
}

resource "google_storage_bucket_object" "mta_sts" {
  bucket = google_storage_bucket.this.name
  name   = ".well-known/mta-sts.txt"
  source = "${path.module}/src/.well-known/mta-sts.txt"
}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.this.name
  role   = "roles/storage.legacyObjectReader"
  member = "allUsers"
}

resource "cloudflare_record" "mta_sts" {
  zone_id = var.cloudflare_zone_id
  name    = "mta-sts"
  type    = "CNAME"
  value   = "c.storage.googleapis.com"
  proxied = true
}
