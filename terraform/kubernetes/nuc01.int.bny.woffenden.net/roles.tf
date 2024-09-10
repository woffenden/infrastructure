resource "kubernetes_role" "paperless_backup" {
  metadata {
    name      = "paperless-backup"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments/scale"]
    verbs      = ["patch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["get"]
  }
}
