# Adding in the ArgoCD AWS KMS creds

Assuming your kubeconfig is configured, your AWS creds are set up appropriately for decryption of the encrypted secrets, and if both `kustomize` and `ksops` are installed locally, you can instantiate ArgoCD with the following command

```bash
kustomize build --enable-alpha-plugins | kubectl apply -f -
```



kustomize build | kubectl apply -f -

kubectl -f argocd-service-ingress.yaml apply

ARGOCD_PASSWORD=$(kubectl -n argo-cd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo $ARGOCD_PASSWORD

argocd login --username admin --password $ARGOCD_PASSWORD --skip-test-tls https://argocd.localhost

kubectl -f argocd-add-repo.yaml apply


argocd repo add git@github.com:mjhfvi/JobAssignment.git --ssh-private-key-path JobAssignment_ssh_login_key_no_password_ed25519


kubectl -f argocd-add-repo.yaml apply
