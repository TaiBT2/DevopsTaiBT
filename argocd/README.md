## COMMAND
ArgoCD là một công cụ triển khai ứng dụng liên tục cho Kubernetes. Nó sử dụng GitOps để quản lý và triển khai các ứng dụng Kubernetes. Dưới đây là một số lệnh cơ bản của ArgoCD mà bạn có thể sử dụng để quản lý các ứng dụng và cụm Kubernetes:

### 1. Đăng nhập vào ArgoCD
```sh
argocd login <ARGOCD_SERVER>
```
- `<ARGOCD_SERVER>`: Địa chỉ của server ArgoCD.

### 2. Thêm một cluster
```sh
argocd cluster add <CONTEXT>
```
- `<CONTEXT>`: Tên context của Kubernetes cluster mà bạn muốn thêm.

### 3. Tạo một ứng dụng mới
```sh
argocd app create <APP_NAME> \
    --repo <REPO_URL> \
    --path <APP_PATH> \
    --dest-server <K8S_CLUSTER_URL> \
    --dest-namespace <NAMESPACE>
```
- `<APP_NAME>`: Tên của ứng dụng.
- `<REPO_URL>`: URL của repository Git chứa mã nguồn ứng dụng.
- `<APP_PATH>`: Đường dẫn đến thư mục chứa các manifest Kubernetes.
- `<K8S_CLUSTER_URL>`: URL của Kubernetes cluster đích.
- `<NAMESPACE>`: Namespace trong Kubernetes cluster nơi ứng dụng sẽ được triển khai.

### 4. Đồng bộ hóa ứng dụng (Sync)
```sh
argocd app sync <APP_NAME>
```
- `<APP_NAME>`: Tên của ứng dụng.

### 5. Kiểm tra trạng thái của ứng dụng
```sh
argocd app get <APP_NAME>
```
- `<APP_NAME>`: Tên của ứng dụng.

### 6. Cập nhật các cài đặt ứng dụng (Set)
```sh
argocd app set <APP_NAME> --parameter <PARAM>=<VALUE>
```
- `<APP_NAME>`: Tên của ứng dụng.
- `<PARAM>`: Tham số cần cập nhật.
- `<VALUE>`: Giá trị mới của tham số.

### 7. Xóa một ứng dụng
```sh
argocd app delete <APP_NAME>
```
- `<APP_NAME>`: Tên của ứng dụng.

### 8. Danh sách các ứng dụng
```sh
argocd app list
```

### 9. Thêm một repository
```sh
argocd repo add <REPO_URL> --username <USERNAME> --password <PASSWORD>
```
- `<REPO_URL>`: URL của repository Git.
- `<USERNAME>`: Tên người dùng Git.
- `<PASSWORD>`: Mật khẩu người dùng Git.

### 10. Kiểm tra các cluster đã được thêm
```sh
argocd cluster list
```

### 11. Cập nhật ArgoCD CLI
```sh
argocd upgrade
```

Những lệnh trên chỉ là một phần nhỏ trong bộ lệnh của ArgoCD. Bạn có thể tìm hiểu thêm chi tiết và các lệnh khác trong tài liệu chính thức của ArgoCD: [ArgoCD CLI Commands](https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd/).
## Tạo file application argocd
Để tạo một ứng dụng trong ArgoCD thông qua file YAML, bạn cần định nghĩa các thông số cần thiết cho ứng dụng của mình như nguồn repository Git, đường dẫn đến các manifest Kubernetes, cluster đích, và namespace đích. Dưới đây là một ví dụ về file YAML cấu hình cho một ứng dụng ArgoCD.

### Ví dụ về File YAML cho Ứng dụng ArgoCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-application
  namespace: argocd
spec:
  project: default
  source:
    repoURL: 'https://github.com/my-org/my-repo.git'
    targetRevision: HEAD
    path: 'path/to/manifests'
  destination:
    server: 'https://kubernetes.default.svc'
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

### Giải thích các trường trong file YAML

- **apiVersion**: Phiên bản API của ArgoCD.
- **kind**: Loại tài nguyên, trong trường hợp này là `Application`.
- **metadata**: Thông tin metadata của ứng dụng.
  - **name**: Tên của ứng dụng.
  - **namespace**: Namespace nơi ứng dụng ArgoCD được triển khai, thường là `argocd`.
- **spec**: Định nghĩa các thông số chi tiết của ứng dụng.
  - **project**: Tên dự án của ArgoCD mà ứng dụng này thuộc về. `default` là dự án mặc định.
  - **source**: Thông tin nguồn của ứng dụng.
    - **repoURL**: URL của repository Git chứa mã nguồn và manifest của ứng dụng.
    - **targetRevision**: Nhánh hoặc commit của repository mà bạn muốn triển khai (ví dụ: `HEAD` cho nhánh chính).
    - **path**: Đường dẫn đến thư mục chứa các manifest Kubernetes trong repository.
  - **destination**: Thông tin đích triển khai của ứng dụng.
    - **server**: URL của Kubernetes API server đích.
    - **namespace**: Namespace trong Kubernetes cluster nơi ứng dụng sẽ được triển khai.
  - **syncPolicy**: Chính sách đồng bộ hóa của ứng dụng.
    - **automated**: Thiết lập tự động đồng bộ hóa.
      - **prune**: Tự động xóa các tài nguyên không còn được định nghĩa trong repository.
      - **selfHeal**: Tự động khôi phục lại trạng thái nếu các tài nguyên bị thay đổi ngoài mong muốn.

### Áp dụng file YAML

Sau khi tạo file YAML, bạn có thể áp dụng nó vào cluster Kubernetes của mình bằng cách sử dụng `kubectl`:

```sh
kubectl apply -f application.yaml
```

Lệnh này sẽ tạo một đối tượng `Application` mới trong ArgoCD và bắt đầu quá trình đồng bộ hóa ứng dụng của bạn từ repository Git đến cluster Kubernetes.