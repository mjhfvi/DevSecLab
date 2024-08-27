# Build the docker image
docker build . -t mjhfvi/clalit-python-env

# Push the docker image
docker push mjhfvi/clalit-python-env

# Add Kubernetes Configurations and Image
kubectl -f python-app-portnode.yml apply
kubectl -f python-environment-variables.yml apply
kubectl -f python-app.yml apply
