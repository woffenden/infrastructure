resource "helm_release" "metallb" {
  /* https://artifacthub.io/packages/helm/metallb/metallb */
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = "0.14.8"
  namespace  = kubernetes_namespace.metallb_system.metadata[0].name
}

resource "helm_release" "cert_manager" {
  /* https://artifacthub.io/packages/helm/cert-manager/cert-manager */
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.16.1"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name

  set {
    name  = "installCRDs"
    value = "true"
  }
}
