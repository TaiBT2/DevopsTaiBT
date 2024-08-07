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

## Add role permission for keyvault step by step
- step 1: go to resource that want to grant role access keyvault
- step 2: go to security > indetity > system asssigned > turn on
- step 3: go to keyvaul > IAM > add role assigment > choose permistion >  manage identity > select member
** reference: https://learn.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=portal%2Chttp
## RPS (request per second)
- RPS = number CPU*(1/ task duration) (time xử lý 1 request) = (total ram/ ram usage)8(1/task duration)
## Settup Mysql Server
- install reference https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-22-04
```
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql.service
```
```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
exit
sudo mysql_secure_installation
ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
```
- Create user to login
```
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION;

CREATE USER 'username'@'%' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

```


## Ingress Rewrite
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: observability-ingress
  namespace: observability
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: $2
spec:
  tls:
    - hosts:
        - observability.vietnamfmc.site
      secretName: observability.vietnamfmc.site
  rules:
    - host: observability.vietnamfmc.site
      http:
        paths:
          - path: /kibana(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: kibana-kibana
                port:
                  number: 5601
          - path: /grafana(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: prometheus-grafana
                port:
                  number: 3000                  

```
## MYSQL
- command backup restore 
```
backup-command: mysqldump -h 47.236.107.98 -u root --port 3306  -p singhai_new > singhai_new_bk.sql
backup-command: mysqldump -h 10.20.22.168 -u root --port 3306  -p smp_testing > smp_testing_bk.sql
backup-command: mysqldump -h 66.42.49.212 -u root --port 3306  -p zhy > zhy_bk.sql
backup-cmd-all-db: mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql
import-cmd-all-db: mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password';
```
- fix bug  Access denied for user 'root'@'localhost' (using password: NO)
```
/etc/my.cnf
/etc/mysql/my.cnf
edit file
[mysqld]
skip-grant-tables
restart server
mysql -u root -p
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'your_new_password';
```
## CREATE BACKUP MYSQL DAILY
- create backup.sh
```
#!/bin/bash

# MySQL credentials
MYSQL_USER="root"
MYSQL_PASSWORD="Rikkei@2024"

# Backup directory
BACKUP_DIR="/home/svdg1/data"

# MySQL dump command
MYSQLDUMP="/usr/bin/mysqldump"

# Date format for backup file
DATE_FORMAT=$(date +"%Y%m%d%H%M%S")

# Loop through each database and dump it
for DB in $(mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e 'show databases' -s --skip-column-names); do
    if [[ "$DB" != "information_schema" && "$DB" != "performance_schema" && "$DB" != "mysql" && "$DB" != "sys" ]]; then
        $MYSQLDUMP -u$MYSQL_USER -p$MYSQL_PASSWORD $DB > $BACKUP_DIR/$DB-$DATE_FORMAT.sql
    fi
done
```
- sudo chmod +x backup.sh
- edit crontab -e
```
0 0 * * * /path/backup.sh
```
## CREATE DISK PARTITION AND VOLUME
- common cmd 
```
- df -h check volume
- lsblk check disk device
- sudo fdisk -l detail all device
- sudo fdisk /dev/sda (press enter) create partition disk
- mount /dev/sda1 /mnt/backup mount volume
```
## Nexus Setting
- Stafulset
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nexus
  namespace: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nexus3
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nexus3
    spec:
      containers:
        - name: nexus3
          image: sonatype/nexus3:latest
          ports:
            - containerPort: 8081
              protocol: TCP
            - containerPort: 8082
              protocol: TCP
            - containerPort: 8083
              protocol: TCP              
          resources: {}
          volumeMounts:
            - name: nexus-data2
              mountPath: /nexus-data
          imagePullPolicy: Always
  volumeClaimTemplates:
    - kind: PersistentVolumeClaim
      apiVersion: v1
      metadata:
        name: nexus-data2
        creationTimestamp: null
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 100Gi
        storageClassName: nfs-csi-retain
        volumeMode: Filesystem

```
- Service resource
```
apiVersion: v1
kind: Service
metadata:
  name: nexus3
  namespace: jenkins
spec:
  ports:
    - name: host
      protocol: TCP
      port: 8081
      targetPort: 8081
    - name: proxy
      protocol: TCP
      port: 8082
      targetPort: 8082
  selector:
    app: nexus3
  type: ClusterIP
```
- change password
- enable anonymous
-  config nexus create hub docker (type hosted)
```
Click Security > Realms
Add the 'Docker Bearer Token Realm'
Click 'Save'

create  new repo type: hosted
HTTP: 8082

Enable Docker V1 API

```
- more infor: 
```
Group — grouping hosted Docker together for easy access granting
Hosted — We will use this. Normal private repos
Proxy — not yet this, this is for forward to download from e.g. Docker hub
link: https://medium.com/codemonday/setup-nexus-oss-on-docker-as-docker-registry-for-learning-748c23f0b951
```
- 
## REGEX
```

khi tôi tạo 1 agent docker để làm agent node cho jenkins bằng ssh thì gặp lỗi Server listening on :: port 22.
Invalid user dg1-swe-sv from 10.20.23.197 port 36614
Connection closed by invalid user dg1-swe-sv 10.20.23.197 port 36614 [preauth]
ChatGPT
Lỗi này cho thấy rằng Jenkins đang cố gắng kết nối với agent Docker qua SSH, nhưng người dùng mà Jenkins đang sử dụng để kết nối (dg1-swe-sv) không tồn tại trên container Docker. Để giải quyết vấn đề này, bạn có thể thực hiện các bước sau:

Tạo người dùng SSH trong container Docker:
Đảm bảo rằng người dùng dg1-swe-sv tồn tại trong container Docker. Bạn có thể thêm người dùng này bằng cách sửa Dockerfile của bạn hoặc chạy lệnh trực tiếp trong container.

Nếu bạn sử dụng Dockerfile, thêm dòng sau:

Dockerfile
Copy code
RUN useradd -m -s /bin/bash dg1-swe-sv
Nếu bạn muốn tạo người dùng trực tiếp trong container đang chạy:

sh
Copy code
docker exec -it <container_id> bash
useradd -m -s /bin/bash dg1-swe-sv
Thiết lập SSH keys:
Bạn cần đảm bảo rằng Jenkins có thể xác thực với agent Docker qua SSH bằng cách sử dụng SSH keys. Đầu tiên, bạn cần tạo SSH key (nếu chưa có):

sh
Copy code
ssh-keygen -t rsa -b 2048 -f ~/.ssh/jenkins_agent_key
Sau đó, copy public key vào file ~/.ssh/authorized_keys của người dùng dg1-swe-sv trong container Docker.

sh
Copy code
cat ~/.ssh/jenkins_agent_key.pub | docker exec -i <container_id> bash -c 'cat >> /home/dg1-swe-sv/.ssh/authorized_keys'
Cấu hình Jenkins để sử dụng SSH key:
Trong Jenkins, vào Manage Jenkins > Manage Nodes. Chọn node tương ứng và cấu hình thông tin kết nối SSH. Đảm bảo bạn sử dụng đường dẫn đến private key đã tạo ở bước trước (~/.ssh/jenkins_agent_key).

Kiểm tra SSH server trong container:
Đảm bảo rằng SSH server đang chạy trong container Docker. Bạn có thể kiểm tra bằng cách chạy lệnh sau trong container:

sh
Copy code
service ssh status
Nếu SSH server chưa chạy, bạn có thể khởi động nó bằng lệnh:

sh
Copy code
service ssh start
Cấu hình quyền sở hữu và quyền truy cập cho SSH:
Đảm bảo rằng quyền sở hữu và quyền truy cập cho các file SSH là chính xác:

sh
Copy code
docker exec -it <container_id> bash
chown -R dg1-swe-sv:dg1-swe-sv /home/dg1-swe-sv/.ssh
chmod 700 /home/dg1-swe-sv/.ssh
chmod 600 /home/dg1-swe-sv/.ssh/authorized_keys
Sau khi thực hiện các bước trên, Jenkins nên có thể kết nối với agent Docker qua SSH mà không gặp lỗi "Invalid user".

bây giờ thì tôi dùng user root nhưng vẫn ko được Connection closed by authenticating user root 10.20.23.197 port 51589 [preauth]
ChatGPT
Nếu bạn vẫn gặp lỗi "Connection closed by authenticating user root" khi sử dụng người dùng root, có thể có một số vấn đề liên quan đến cấu hình SSH hoặc Docker container. Dưới đây là các bước chi tiết để kiểm tra và khắc phục:

Kiểm tra SSH Server:
Đảm bảo rằng SSH server đang chạy trong container Docker:

sh
Copy code
docker exec -it <container_id> service ssh status
Nếu SSH server chưa chạy, khởi động nó bằng lệnh:

sh
Copy code
docker exec -it <container_id> service ssh start
Kiểm tra cấu hình SSH:
Đảm bảo rằng cấu hình SSH trong container Docker cho phép đăng nhập root. Mở file /etc/ssh/sshd_config và kiểm tra các dòng sau:

sh
Copy code
docker exec -it <container_id> bash
nano /etc/ssh/sshd_config
Cho phép đăng nhập root:
sh
Copy code
PermitRootLogin yes
Đảm bảo SSH sử dụng phương thức xác thực bằng key:
sh
Copy code
PubkeyAuthentication yes
Sau khi chỉnh sửa, khởi động lại SSH server:

sh
Copy code
service ssh restart
Thiết lập SSH keys cho root:
Đảm bảo rằng key công khai của Jenkins đã được thêm vào ~/.ssh/authorized_keys của người dùng root trong container:

sh
Copy code
cat ~/.ssh/jenkins_agent_key.pub | docker exec -i <container_id> bash -c 'cat >> /root/.ssh/authorized_keys'
Thiết lập quyền sở hữu và quyền truy cập:
Đảm bảo rằng các file SSH có quyền sở hữu và quyền truy cập chính xác:

sh
Copy code
docker exec -it <container_id> bash
chown -R root:root /root/.ssh
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
Kiểm tra kết nối SSH từ máy Jenkins:
Thử kết nối trực tiếp từ máy Jenkins đến container Docker bằng SSH để kiểm tra xem có vấn đề gì không:

sh
Copy code
ssh -i ~/.ssh/jenkins_agent_key root@<docker_container_ip>
Nếu kết nối này thành công, vấn đề có thể nằm ở cấu hình Jenkins.

Cấu hình Jenkins để sử dụng SSH key:
Trong Jenkins, vào Manage Jenkins > Manage Nodes. Chọn node tương ứng và cấu hình thông tin kết nối SSH. Đảm bảo bạn sử dụng đường dẫn đến private key đã tạo (~/.ssh/jenkins_agent_key).

Kiểm tra logs của SSH server:
Kiểm tra logs của SSH server trong container để xem thông tin chi tiết về lỗi:

sh
Copy code
docker exec -it <container_id> tail -f /var/log/auth.log
Nếu bạn đã thực hiện tất cả các bước trên mà vẫn gặp vấn đề, vui lòng cung cấp thêm thông tin về logs của SSH server để có thể hỗ trợ chi tiết hơn.

hướng dẫn tạo regexx
ChatGPT
Để tạo một biểu thức chính quy (regular expression - regex), bạn cần hiểu cú pháp và các thành phần cơ bản của regex. Regex là một công cụ mạnh mẽ để tìm kiếm và xử lý chuỗi văn bản. Dưới đây là một hướng dẫn cơ bản để tạo regex.

1. Các thành phần cơ bản của regex
Ký tự thường: Đại diện cho chính nó. Ví dụ: a khớp với ký tự 'a'.

Ký tự đặc biệt:

.: Khớp với bất kỳ ký tự nào ngoại trừ newline.
\d: Khớp với bất kỳ chữ số nào (0-9).
\w: Khớp với bất kỳ ký tự chữ cái, chữ số hoặc dấu gạch dưới.
\s: Khớp với bất kỳ ký tự khoảng trắng nào (space, tab, newline).
\b: Khớp với biên giới của từ (word boundary).
\t: Khớp với tab.
Ký tự đại diện:

[abc]: Khớp với bất kỳ ký tự nào trong dấu ngoặc vuông.
[a-z]: Khớp với bất kỳ ký tự nào từ a đến z.
[^abc]: Khớp với bất kỳ ký tự nào không có trong dấu ngoặc vuông.
Ký tự lặp lại:

*: Khớp với 0 hoặc nhiều lần xuất hiện của ký tự trước đó.
+: Khớp với 1 hoặc nhiều lần xuất hiện của ký tự trước đó.
?: Khớp với 0 hoặc 1 lần xuất hiện của ký tự trước đó.
{n}: Khớp với chính xác n lần xuất hiện của ký tự trước đó.
{n,}: Khớp với ít nhất n lần xuất hiện của ký tự trước đó.
{n,m}: Khớp với ít nhất n và nhiều nhất m lần xuất hiện của ký tự trước đó.
Nhóm và lựa chọn:

(abc): Nhóm các ký tự lại với nhau.
a|b: Khớp với a hoặc b.
Ký tự neo:

^: Khớp với bắt đầu chuỗi.
$: Khớp với kết thúc chuỗi.
```
## SRS ứng dụng blockchain cho tiền điện tử
Dưới đây là một bản phác thảo Tài liệu Yêu cầu Hệ thống (SRS) cho ứng dụng blockchain vào tiền điện tử như Bitcoin. Đây là một tài liệu tổng quan và bạn có thể điều chỉnh nó để phù hợp với yêu cầu cụ thể của dự án của bạn.

### Tài liệu Yêu cầu Hệ thống (SRS) cho Ứng dụng Blockchain vào Tiền Điện Tử

#### 1. Giới thiệu
- **Mục tiêu**: Xây dựng một ứng dụng tiền điện tử sử dụng công nghệ blockchain để cung cấp một phương tiện thanh toán an toàn, minh bạch và phi tập trung.
- **Phạm vi**: Phát triển một nền tảng cho phép người dùng gửi và nhận tiền điện tử, quản lý ví điện tử và thực hiện các giao dịch một cách an toàn trên blockchain.
- **Định nghĩa và viết tắt**: 
  - Blockchain: Công nghệ lưu trữ và truyền tải thông tin một cách minh bạch và an toàn.
  - Tiền điện tử: Loại tiền tệ kỹ thuật số được giao dịch trên blockchain.

#### 2. Mô tả tổng quan
- **Quan điểm hệ thống**: Hệ thống sẽ cung cấp một nền tảng cho phép người dùng trao đổi, lưu trữ và quản lý tiền điện tử một cách an toàn và bảo mật.
- **Chức năng của hệ thống**:
  - Quản lý ví điện tử và các khóa công khai/riêng tư.
  - Thực hiện các giao dịch tiền điện tử giữa các tài khoản người dùng.
  - Lưu trữ lịch sử giao dịch trên blockchain để đảm bảo minh bạch và tính chính xác.
- **Đặc điểm người dùng**: Bao gồm các người dùng cá nhân, doanh nghiệp hoặc tổ chức muốn sử dụng và quản lý tiền điện tử.

#### 3. Yêu cầu chức năng
- **Quản lý ví điện tử**:
  - Tạo và quản lý ví điện tử của người dùng.
  - Cung cấp khả năng xử lý các loại tiền điện tử khác nhau.
  - Cung cấp khả năng sao lưu và phục hồi ví điện tử.

- **Giao dịch tiền điện tử**:
  - Cho phép người dùng gửi và nhận tiền điện tử với các giao dịch được xác thực bằng blockchain.
  - Xác nhận giao dịch và cập nhật số dư ví điện tử một cách tức thời.

- **Lịch sử giao dịch**:
  - Lưu trữ và hiển thị lịch sử giao dịch của từng tài khoản ví điện tử.
  - Cung cấp khả năng tìm kiếm và theo dõi thông tin chi tiết của từng giao dịch.

#### 4. Yêu cầu phi chức năng
- **Bảo mật và quản lý khóa**:
  - Đảm bảo an toàn thông tin người dùng và các khóa cá nhân/riêng tư.
  - Áp dụng các biện pháp bảo mật như xác thực hai yếu tố và mã hóa dữ liệu.

- **Hiệu suất**:
  - Đảm bảo hệ thống có khả năng xử lý số lượng giao dịch lớn một cách hiệu quả và nhanh chóng.
  - Thời gian xử lý giao dịch nhanh để đáp ứng nhu cầu thời gian thực của người dùng.

- **Tính khả dụng**:
  - Đảm bảo hệ thống có khả năng hoạt động liên tục và khả dụng cao (uptime trên 99%).
  - Sao lưu và phục hồi dữ liệu định kỳ để đối phó với sự cố.

#### 5. Yêu cầu giao diện
- **Giao diện người dùng**:
  - Giao diện web và ứng dụng di động thân thiện và dễ sử dụng.
  - Các chức năng quản lý ví điện tử và thực hiện giao dịch được bố trí rõ ràng và dễ tiếp cận.

#### 6. Các yêu cầu khác
- **Các tiêu chuẩn và quy định**:
  - Tuân thủ các quy định pháp lý liên quan đến tiền điện tử và dữ liệu cá nhân.
  - Đáp ứng các tiêu chuẩn bảo mật thông tin như GDPR.

### Tài liệu tham khảo
- Các tài liệu và tiêu chuẩn về tiền điện tử và blockchain.
- Các nền tảng và công nghệ blockchain phổ biến như Bitcoin, Ethereum.

---

Đây là một bản phác thảo và bạn có thể thay đổi, điều chỉnh để phù hợp với yêu cầu cụ thể của dự án của bạn. Nếu bạn có bất kỳ câu hỏi nào khác hoặc cần sự hỗ trợ thêm, hãy để lại câu hỏi!