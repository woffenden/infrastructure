resource "kubernetes_manifest" "metallb_ip_address_pool_bny_woffenden_net" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"
    metadata = {
      name      = "bny-woffenden-net"
      namespace = kubernetes_namespace.metallb_system.metadata[0].name
    }
    spec = {
      addresses = [
        "10.100.0.51-10.100.0.60"
      ]
    }
  }
}

resource "kubernetes_manifest" "metallb_l2_advertisement_bny_woffenden_net" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "L2Advertisement"
    metadata = {
      name      = "bny-woffenden-net"
      namespace = kubernetes_namespace.metallb_system.metadata[0].name
    }
    spec = {
      ipAddressPools = [
        "bny-woffenden-net"
      ]
    }
  }
}

import {
  to = kubernetes_manifest.metallb_l2_advertisement_bny_woffenden_net
  id = "apiVersion=metallb.io/v1beta1,kind=L2Advertisement,namespace=metallb-system,name=bny-woffenden-net"
}
