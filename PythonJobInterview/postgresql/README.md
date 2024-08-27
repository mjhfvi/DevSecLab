# source: https://artifacthub.io/packages/helm/bitnami/postgresql
# Add Bitnami Repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Add a Configmap for Volume Persistent (Local Settings)
kubectl -f postgres-volume-persistent-nfs.yml apply
kubectl -f postgres-volume-persistent-claim.yml apply
kubectl -f postgres-secrets.yml apply

# Install the Nginx Helm Chart
# Change the VPC "existingClaim", add an option to manage the sql
helm install postgresql-db oci://registry-1.docker.io/bitnamicharts/postgresql \
--set global.postgresql.auth.existingSecret=postgresql-db-secret-basic-auth \
--set global.postgresql.auth.secretKeys.adminPasswordKey=password \
--set primary.persistence.enabled=true \
--set primary.persistence.size=2Gi \
--set primary.persistence.existingClaim=postgres-persistent-volume-claim-nfs

# this will open access to the db outside of the cluster
<!-- --set primary.service.type=NodePort \ -->
<!-- --set primary.service.ports.postgresql=5432 -->
<!-- --set primary.service.nodePorts.postgresql=30001 -->

# use this without a secret,
# remove global.postgresql.auth.existingSecret & global.postgresql.postgresqlPasswordKey
# export POSTGRES_PASSWORD=dbsecretpassword
--set auth.postgresPassword=$POSTGRES_PASSWORD \

# get the DNS name for the postgresql Pod
postgresql connection name in the cluster: postgresql-db.default.svc.cluster.local - Read/Write connection
get service information: kubectl get all,svc,secrets,pods,pvc,pv
open postgresql port 5432: kubectl port-forward --namespace default svc/postgresql-db 5432:5432
connect to postgresql: psql --host localhost -U postgres -d postgres -p 5432


## Troubleshooting ##
kubectl get all,pods,statefulset,configmap

helm uninstall postgresql-db
