Introduce

Note dùng để tóm tắt kinh nghiệm devops

* Những helm chart thường sử dụng (Fluentbit, grafana, prometheus)
* Command thường dùng trong linux
* Kinh nghiệm xương máu


## Argocd set webhook for git
- set secret for argocd for bitbucket,git,...
```
  secret:
    ## @param config.secret.create Whether to create or not the secret
    ##
    create: true
    ## Annotations to be added to argocd-secret
    ## @param config.secret.annotations General secret extra annotations
    ##
    annotations: {}

    ## Webhook Configs
    ## @param config.secret.githubSecret GitHub secret to configure webhooks
    ## @param config.secret.gitlabSecret GitLab secret to configure webhooks
    ## @param config.secret.bitbucketServerSecret BitBucket secret to configure webhooks
    ## @param config.secret.bitbucketUUID BitBucket UUID to configure webhooks
    ## @param config.secret.gogsSecret Gogs secret to configure webhooks
    ##
    githubSecret: ""
    gitlabSecret: ""
    bitbucketServerSecret: "" -> secret
    bitbucketUUID: ""
    gogsSecret: ""

```
- config webhook for repo bitbucket https://<argocd.url>/api/websocket and secret. Remember click checkbox **active** to sync.
## RBAC Kubernetes
```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: banca-developer
---
apiVersion: v1
kind: Secret
metadata:
  name: banca-developer-token
  annotations:
    kubernetes.io/service-account.name: banca-developer
type: kubernetes.io/service-account-token
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: banca-clusterrole
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["list", "get", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get","list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments/scale"]
  verbs: ["update"]
- apiGroups: [""]
  resources: ["services"]
  verbs: ["get","list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: b22dadtubac-dev-cloud
  name: vault-dev
rules:
- apiGroups: ["*"] # 
  resources: ["*"]
  verbs: ["*"]
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: banca-clusterrolebinding
subjects:
- kind: ServiceAccount
  name: banca-developer
  namespace: default
roleRef:
  kind: ClusterRole
  name: banca-clusterrole
  apiGroup: rbac.authorization.k8s.io

```
# GCE Controller
- service for ingress type: NodePort
- ingress form
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-production
  annotations:
    kubernetes.io/ingress.class: gce
    kubernetes.io/ingress.global-static-ip-name: xeca-production
    networking.gke.io/managed-certificates: websocket-cm ,superadmin-cm, apigateway-cm , vamminh-cm, vinhquang-cm,logging-cm, vinhquang
    networking.gke.io/v1beta1.FrontendConfig: http-to-https
  namespace: s22nbaeqxeca-production
spec:
  rules:
  - host: superadmin.xeca.vn
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: xeca-admin-service-production-svc
            port: 
              number: 81
  - host: api-pro.xeca.vn
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: apigw-service-production-svc
            port: 
              number: 8080
  - host: logging.xeca.vn
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: grafana
            port: 
              number: 3000
  - host: websocket.xeca.vn
    http:
      paths:
      - pathType: Prefix
        path: "/ticket-socket"
        backend:
          service:
            name: ticket-service-production-svc
            port: 
              number: 3003
      - pathType: Prefix
        path: "/notification-socket"
        backend:
          service:
            name: notification-service-production-svc
            port: 
              number: 3007
```
- Certmanager for ingress
```

apiVersion: networking.gke.io/v1
kind: ManagedCertificate
metadata:
  name: superadmin-cm
  namespace: s22nbaeqxeca-production
spec:
  domains:
    - superadmin.xeca.vn
---
apiVersion: networking.gke.io/v1
kind: ManagedCertificate
metadata:
  name: apigateway-cm
  namespace: s22nbaeqxeca-production
spec:
  domains:
    - api-pro.xeca.vn
---

apiVersion: networking.gke.io/v1
kind: ManagedCertificate
metadata:
  name: websocket-cm
  namespace: s22nbaeqxeca-production
spec:
  domains:
    - websocket.xeca.vn
---
apiVersion: networking.gke.io/v1
kind: ManagedCertificate
metadata:
  name: logging-cm
  namespace: s22nbaeqxeca-production
spec:
  domains:
    - logging.xeca.vn
    
```
- Backend config use for config healthcheck, websocket (Timeout),...
```
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: web-config-backend
  namespace: s22nbaeqxeca-production
spec:
  # timeoutSec: 1800
  # connectionDraining:
  #   drainingTimeoutSec: 1800
  healthCheck:
    checkIntervalSec: 10
    timeoutSec: 5
    healthyThreshold: 1
    unhealthyThreshold: 2
    type: HTTP
    requestPath: /actuator/health
    port: 32153
---
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: web-config-backend
  namespace: kube-system
spec:
  # timeoutSec: 1800
  # connectionDraining:
  #   drainingTimeoutSec: 1800
  healthCheck:
    checkIntervalSec: 10
    timeoutSec: 5
    healthyThreshold: 1
    unhealthyThreshold: 2
    type: HTTP
    requestPath: /healthz
    port: 30263
--- 
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: xecaadmin-backend
  namespace: s22nbaeqxeca-production
spec:

  healthCheck:
    checkIntervalSec: 10
    timeoutSec: 5
    healthyThreshold: 1
    unhealthyThreshold: 2
    type: HTTP
    requestPath: /actuator/health
    port: 31257
---
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: ticket-config-backend
  namespace: s22nbaeqxeca-production
spec:
  cdn:
    enabled: true
    cachePolicy:
      includeHost: false
      includeProtocol: true
      includeQueryString: false
  sessionAffinity:
    affinityType: "GENERATED_COOKIE"
    affinityCookieTtlSec: 50
  timeoutSec: 1800
  connectionDraining:
    drainingTimeoutSec: 1800
  healthCheck:
    checkIntervalSec: 10
    timeoutSec: 5
    healthyThreshold: 1
    unhealthyThreshold: 2
    type: HTTP
    requestPath: /__healthcheck
    port: 31927
---
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: notify-config-backend
  namespace: s22nbaeqxeca-production
spec:
  cdn:
    enabled: true
    cachePolicy:
      includeHost: false
      includeProtocol: true
      includeQueryString: false
  sessionAffinity:
    affinityType: "GENERATED_COOKIE"
    affinityCookieTtlSec: 50
  timeoutSec: 1800
  connectionDraining:
    drainingTimeoutSec: 1800
  healthCheck:
    checkIntervalSec: 10
    timeoutSec: 5
    healthyThreshold: 1
    unhealthyThreshold: 2
    type: HTTP
    requestPath: /__healthcheck
    port: 31211

```
***
**Note: create External Ip for load balancer first**
## HTTP Security Headers
- HTTP Strict Transport Security (HSTS): kết nối an toàn web, server  buộc là phải giao tiếp https, max age:  thời gian truy cập https, IncludeSubDomains : cấu hình cho subdomain
  ```
  Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
  ```
- Content Security Policy (CSP): Hạn chế tài nguyên mà người dùng được phép tải trên website
  ```
  Content-Security-Policy: <policy-directive>; <policy-directive>
  Content-Security-Policy: script-src 'self' https://viblo.asia
  //chỉ cho phép tải qua website https://viblo.asia
  ```
- Cross Site Scripting Protection (X-XSS): bảo vệ các cuộc tấn công XSS có 4 chế độ

  - 0: Bộ lọc XSS bị vô hiệu hóa.

  - 1: Bộ lọc XSS được kích hoạt và bảo vệ trang nếu phát hiện tấn công.

  - 1;mode=block: Bộ lọc XSS được kích hoạt và ngăn chặn hiển thị trang nếu phát hiện tấn công.

  - 1;report=https://viblo.asia: Bộ lọc XSS được kích hoạt và báo cáo vi phạm nếu phát hiện cuộc tấn công.
  ```
  X-XSS-Protection: 0
  X-XSS-Protection: 1
  X-XSS-Protection: 1; mode=block
  X-XSS-Protection: 1; report=<reporting-uri>
  ```
- X-Frame-Options:
  - Kĩ thuật giả mạo Clickjacking là lừa người dùng click thứ gì đó không có ở trong website
  - Option này ngăn chặn hoặc vô hiệu hóa iframe có trên website
  - có 3 options: SAMEORIGIN: chỉ cho phép từ nguồn gốc, DENY: Ngăn chặn bất kì các tên miền nào, ALLOW-FROM: chỉ cho phép từ URI cụ thể
  ```
  X-Frame-Options: DENY
  X-Frame-Options: SAMEORIGIN
  X-Frame-Options: ALLOW-FROM https://viblo.asia
  ```
  ## Turn off version nginx
  add this option in config server of nginx
  ```
  server_tokens off;
  ```
## KANIKO
```
  https://github.com/GoogleContainerTools/kaniko
```
## NGINX
- ssh root@10.0.0.12 -i id_rsa_orgin
## K8S pull image from artifact registry
- create secret
```
kubectl -n b22dadtubac-prod-gcp create secret docker-registry regcred-repo-edsolabs \
--docker-server=https://asia-southeast1-docker.pkg.dev \
--docker-email=artifact-cleo-prod@cleo-prod.iam.gserviceaccount.com \
--docker-username=_json_key \
--docker-password="$(cat cleo-prod-b508617b9167.json)"
```
- add secret to image pull secret 
## Intergrate keyvault with aks
- turn on identity virtual machine scale set
- Keyvault: Access controll (IAM) ->  add resource assigament -> choose role -> add member (assign managed identity)
- enable addons azure-keyvault
```
az aks enable-addons --addons azure-keyvault-secrets-provider --name aksdemocluster --resource-group aksdemocluster-rg
```
- create secretproviderclass
```
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: azure-kvname-system-msi
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    useVMManagedIdentity: "true"    # Set to true for using managed identity
    userAssignedIdentityID: ""      # If empty, then defaults to use the system assigned identity on the VM
    keyvaultName: aksdemocluster-kv
    cloudName: "AzurePublicCloud"                   # [OPTIONAL for Azure] if not provided, the Azure environment defaults to AzurePublicCloud
    objects:  |
      array:
        - |
          objectName: dev2-*
          objectType: secret        # object types: secret, key, or cert
          objectVersion: ""         # [OPTIONAL] object versions, default to latest if empty
    tenantId: e276db94-bd4f-4502-b458-b1c6fcefdcf2          # The tenant ID of the key vault
```
```
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: azure-sync
  namespace: b22dadtubac-dev-cloud
spec:
  provider: azure  
  parameters:
    usePodIdentity: "false"
    useVMManagedIdentity: "true"         
    userAssignedIdentityID: ""   
    keyvaultName: "CleoVaultDev" 
    tenantId: e276db94-bd4f-4502-b458-b1c6fcefdcf2 
    objects:  |
      array:k apply 
        - |
          objectName: dev2-BCWORKER-AM-BASE-URL-VAULT
          objectType: secret
        - |
          objectName: dev2-BCWORKER-AZURE-SERVICE-BUS-CONNECTION-STRING
          objectType: secret                                 
  secretObjects:                              # [OPTIONAL] SecretObjects defines the desired state of synced Kubernetes secret objects
  - data:
    - key: urlvault                           # data field to populate
      objectName: dev2-BCWORKER-AM-BASE-URL-VAULT                        # name of the mounted content to sync; this could be the object name or the object 
    secretName: bcworker                     # name of the Kubernetes secret object
    type: Opaque 
```
- Create Pod use Secret
```

kind: Pod
apiVersion: v1
metadata:
  name: busybox-secrets-store-inline-system-msi
spec:
  containers:
    - name: busybox
      image: k8s.gcr.io/e2e-test-images/busybox:1.29-1
      command:
        - "/bin/sleep"
        - "10000"
      volumeMounts:
      - name: secrets-store01-inline
        mountPath: "/mnt/secrets-store"
        readOnly: true
  volumes:
    - name: secrets-store01-inline
      csi:
        driver: secrets-store.csi.k8s.io
        readOnly: true
        volumeAttributes:
          secretProviderClass: "azure-kvname-system-msi"
```
```
kind: Pod
apiVersion: v1
metadata:
  name: secret-pod
  namespace: b22dadtubac-dev-cloud
spec:
  containers:
    - name: busybox
      image: k8s.gcr.io/e2e-test-images/busybox:1.29-1
      command:
        - "/bin/sleep"
        - "10000"
      env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: bcworker
            key: urlvault
```
## ENJECT VAULT AGENT POD K8S
- step 1: Authen and get issuer by command
```
- kubectl get --raw /.well-known/openid-configuration
- vault auth enable kubernetes

- vault write auth/kubernetes/config \
  token_reviewer_jwt="$(TOKEN_SERVICE_ACCOUNT)" \
  kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
  issuer="https://cleodevcluster-dns-wv0ej0np.hcp.southeastasia.azmk8s.io"
```

- step 2: create path and  create policy
```
vault secrets enable -path=cleo/dev2 kv

vault policy write cleo-dev2 - << EOF
path "cleo/dev2/*" {
  capabilities = ["read", "update", "list"]
}
EOF

vault kv put cleo/dev2/store username=cleo-admin pass=sdfasdsd2132
```
- step 3: create role
```
vault write auth/kubernetes/role/cleo-dev2 \
    bound_service_account_names=vault-dev \
    bound_service_account_namespaces=b22dadtubac-dev-cloud \
    policies=cleo-dev2 \
    ttl=30h
```
- step 4: create token from policy
```
vault token create -policy=cleo-dev2 -period=768h
```
- step 5: inject vault agent to pod
```
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu3
  namespace: b22dadtubac-dev-cloud
  annotations:
    vault.hashicorp.com/agent-inject: 'true'
    vault.hashicorp.com/agent-inject-secret-.env: cleo/dev2/store
    vault.hashicorp.com/agent-inject-template-.env: |
      {{- with secret "cleo/dev2/store" -}}
      {{ range $k, $v := .Data.data }}
      {{ $k }}="{{ $v | printf "%s" }}"
      {{ end }}
      {{- end -}}    
    vault.hashicorp.com/role: cleo-dev2
    vault.hashicorp.com/auth-path: auth/kubernetes
spec:
  serviceAccountName: vault-dev
  containers:
  - name: ubuntu
    image: ubuntu
    command:
    - sleep
    - infinity
    resources:
      limits:
        memory: "128Mi"
        cpu: "200m" 
```
## COMMON COMAND
- Out of RAM
```
sync; echo 1 > /proc/sys/vm/drop_caches
```
## SERVICE
`Preserving the client source IP`
- Mặc dịnh target container sẽ không nhìn thấy ip gốc client. .spec.externalTrafficPolicy= Cluster (default)
- ![alt](./image/svc-external.png)
