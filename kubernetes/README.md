1. Install K3s

```bash
curl -sfL https://get.k3s.io | sh -s - server --no-deploy traefik --no-deploy servicelb
```

2. Install MetalLB

```bash
/usr/local/bin/kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
/usr/local/bin/kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
/usr/local/bin/kubectl apply -f metallb-configmap.yaml
```

3. Install Ingress NGINX

```bash
/usr/local/bin/kubectl apply -f ingress-nginx.yaml
```