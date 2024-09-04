data "google_secret_manager_secret_version" "k8s_nuc01_certificate_authority_data" {
  secret = "k8s-nuc01-certificate-authority-data"
}

data "google_secret_manager_secret_version" "k8s_nuc01_client_certificate_data" {
  secret = "k8s-nuc01-client-certificate-data"
}

data "google_secret_manager_secret_version" "k8s_nuc01_client_key_data" {
  secret = "k8s-nuc01-client-key-data"
}
