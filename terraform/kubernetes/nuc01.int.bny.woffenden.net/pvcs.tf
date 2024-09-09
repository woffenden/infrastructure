resource "kubernetes_persistent_volume_claim" "homebridge" {
  metadata {
    name      = "homebridge-pvc"
    namespace = kubernetes_namespace.homebridge.metadata[0].name
  }
  spec {
    storage_class_name = "local-path"
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}
