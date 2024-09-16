resource "kubernetes_role_binding" "paperless_backup" {
  metadata {
    name      = "paperless-backup"
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.paperless_backup.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.paperless_backup.metadata[0].name
    namespace = kubernetes_namespace.paperless.metadata[0].name
  }
}
