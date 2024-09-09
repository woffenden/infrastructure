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

resource "kubernetes_persistent_volume_claim" "paperless_redis" {
  metadata {
    name      = "redis-pvc"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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

resource "kubernetes_persistent_volume_claim" "paperless_postgres" {
  metadata {
    name      = "postgres-pvc"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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

resource "kubernetes_persistent_volume_claim" "paperless_consume" {
  metadata {
    name      = "paperless-consume-pvc"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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

resource "kubernetes_persistent_volume_claim" "paperless_data" {
  metadata {
    name      = "paperless-data-pvc"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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

resource "kubernetes_persistent_volume_claim" "paperless_export" {
  metadata {
    name      = "paperless-export-pvc"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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

resource "kubernetes_persistent_volume_claim" "paperless_media" {
  metadata {
    name      = "paperless-media-pvc"
    namespace = kubernetes_namespace.paperless.metadata[0].name
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
