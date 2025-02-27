# source: https://artifacthub.io/packages/helm/bitnami/nginx
# Add Bitnami Repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Add a configmap for the server block and index configurations
kubectl -f nginx-configmap-config.yml apply
kubectl -f nginx-configmap-html-index.yml apply

# Install the Nginx Helm Chart on kubernetes
helm install nginx-web-server oci://registry-1.docker.io/bitnamicharts/nginx --set primary.containerSecurityContext.runAsNonRoot=true --set service.type=LoadBalancer --set service.ports.http=8080 --set containerSecurityContext.runAsUser=1000850001 --values=custom_server_block.conf

# Install the Nginx Helm Chart on OpenShift
helm install nginx-web-server oci://registry-1.docker.io/bitnamicharts/nginx --set primary.containerSecurityContext.runAsNonRoot=true --set service.type=LoadBalancer --set service.ports.http=8080 --set containerSecurityContext.runAsUser=1000850001 --set ingress.enabled=true --values=custom_server_block.conf

# add ingress for public URL, source: https://github.com/bitnami/charts/tree/main/bitnami/nginx-ingress-controller
helm install nginx-ingress-controller oci://registry-1.docker.io/bitnamicharts/nginx-ingress-controller


# Troubleshooting
kubectl get all,pods,statefulset,configmap

helm uninstall nginx-web-server
