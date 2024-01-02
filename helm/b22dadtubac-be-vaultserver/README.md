1. Install Vault Server

helm upgrade --install b22dadtubac-be-vaultserver ./b22dadtubac-be-vaultserver --namespace b22dadtubac-prod-cloud --value 

<!-- helm upgrade --install --force b22dadtubac-be-vaultserver-dev /synodus/projects/devops/helmTemplates/BANCA/DEV/b22dadtubac-be-vaultserver --namespace banca-dev -->
* config postgres: https://developer.hashicorp.com/vault/docs/configuration/storage/postgresql#postgresql-parameters
2. Init Vault Server

kubectl exec -n banca-dev --stdin=true --tty=true b22dadtubac-be-vaultserver-dev-0 -- vault operator init

Lưu giữ bí mật toàn bộ nôi dung key hiển thị ra


3. Unseal Vault Server

Sử dụng Unseal Key để unseal:

kubectl exec -n banca-dev --stdin=true --tty=true b22dadtubac-be-vaultserver-dev-0 -- vault operator unseal key 1
kubectl exec -n banca-dev --stdin=true --tty=true b22dadtubac-be-vaultserver-dev-0 -- vault operator unseal key 2
kubectl exec -n banca-dev --stdin=true --tty=true b22dadtubac-be-vaultserver-dev-0 -- vault operator unseal key 3
