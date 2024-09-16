resource "kubernetes_service_account" "paperless_backup" {
  metadata {
    name      = "paperless-backup"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
}
