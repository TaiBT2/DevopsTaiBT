## HPA based on SQS
Để tự động tăng số lượng pod khi số lượng message trong hàng đợi SQS vượt quá 100, bạn có thể sử dụng KEDA (Kubernetes-based Event Driven Autoscaling). Dưới đây là các bước chi tiết để triển khai giải pháp này:

### 1. Cài đặt KEDA (Kubernetes-based Event Driven Autoscaling)
KEDA giúp tự động tăng hoặc giảm số lượng pod dựa trên các sự kiện từ các nguồn bên ngoài, như AWS SQS.

#### Cài đặt KEDA
1. **Cài đặt Helm (nếu chưa có):**
   ```bash
   curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
   ```

2. **Thêm KEDA Helm repository và cài đặt KEDA:**
   ```bash
   helm repo add kedacore https://kedacore.github.io/charts
   helm repo update
   helm install keda kedacore/keda --namespace keda --create-namespace
   ```

### 2. Tạo IAM Role và Policy cho KEDA

Dưới đây là các bước chi tiết để tạo IAM Role và gán IAM Role này cho KEDA sử dụng:

### Bước 1: Tạo IAM Role và Policy
#### Tạo IAM Policy
1. Đăng nhập vào AWS Management Console.
2. Điều hướng đến **IAM**.
3. Chọn **Policies** và sau đó chọn **Create policy**.
4. Sử dụng trình tạo chính sách JSON và nhập chính sách sau:
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "sqs:GetQueueAttributes",
            "sqs:GetQueueUrl"
          ],
          "Resource": "arn:aws:sqs:<region>:<account-id>:<queue-name>"
        }
      ]
    }
    ```
5. Chọn **Review policy**, đặt tên cho chính sách này (ví dụ: `KedaSQSAccessPolicy`), và sau đó tạo chính sách.

#### Tạo IAM Role
1. Quay lại trang chính IAM, chọn **Roles** và sau đó chọn **Create role**.
2. Chọn **Web identity** và chọn **OIDC provider** của cluster Kubernetes.
3. Chọn **Next: Permissions**, gán chính sách `KedaSQSAccessPolicy` mà bạn vừa tạo.
4. Chọn **Next: Tags** (tuỳ chọn), và sau đó chọn **Next: Review**.
5. Đặt tên cho Role này (ví dụ: `KedaSQSRole`), và tạo Role.

### Bước 2: Cấu hình Kubernetes để sử dụng IAM Role
#### Cài đặt và cấu hình IAM Roles for Service Accounts (IRSA)
1. **Cài đặt `eksctl`** (nếu chưa có):
    ```bash
    curl --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    ```

2. **Tạo IAM OIDC provider** (nếu chưa có):
    ```bash
    eksctl utils associate-iam-oidc-provider --region <region> --cluster <cluster-name> --approve
    ```

3. **Tạo IAM Role và ServiceAccount**:
    ```bash
    eksctl create iamserviceaccount \
      --name keda-service-account \
      --namespace default \
      --cluster <cluster-name> \
      --attach-policy-arn arn:aws:iam::<account-id>:policy/KedaSQSAccessPolicy \
      --approve \
      --override-existing-serviceaccounts
    ```
#### IAM Policy
1. Tạo IAM Policy với quyền đọc từ SQS:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "sqs:GetQueueAttributes",
           "sqs:GetQueueUrl"
         ],
         "Resource": "arn:aws:sqs:<region>:<account-id>:<queue-name>"
       }
     ]
   }
   ```

2. Gắn Policy này vào IAM Role mà KEDA sử dụng.

### 3. Tạo Kubernetes Deployment và HPA với KEDA
Tạo một deployment và cấu hình HPA với KEDA để tự động tăng giảm số lượng pod dựa trên số lượng tin nhắn trong SQS.

#### Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sqs-consumer
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sqs-consumer
  template:
    metadata:
      labels:
        app: sqs-consumer
    spec:
      containers:
      - name: sqs-consumer
        image: your-image
        ports:
        - containerPort: 80
        env:
        - name: AWS_REGION
          value: <region>
        - name: QUEUE_URL
          value: <queue-url>
```

#### KEDA ScaledObject
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: sqs-queue-scaler
  namespace: default
spec:
  scaleTargetRef:
    kind: Deployment
    name: sqs-consumer
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
  - type: aws-sqs-queue
    metadata:
      queueURL: <queue-url>
      queueLength: "100"
      awsRegion: <region>
```

### 4. Áp dụng các tệp YAML
```bash
kubectl apply -f deployment.yaml
kubectl apply -f scaledobject.yaml
```

### 5. Kiểm tra
Gửi các tin nhắn vào hàng đợi SQS và kiểm tra xem KEDA có tự động tăng số lượng pod khi số lượng tin nhắn vượt quá 100 không.

### Tóm tắt
- **Cài đặt KEDA**: Sử dụng Helm để cài đặt KEDA vào cluster Kubernetes.
- **Tạo IAM Policy**: Đảm bảo KEDA có quyền truy cập vào SQS.
- **Tạo Deployment và ScaledObject**: Cấu hình deployment cho ứng dụng và KEDA ScaledObject để điều chỉnh số lượng pod dựa trên số lượng tin nhắn trong SQS.
## HPA based on cloudwatch
Nếu bạn muốn tự động tăng giảm số lượng pod dựa trên metric CloudWatch, bạn có thể sử dụng AWS CloudWatch Metrics với Kubernetes HPA (Horizontal Pod Autoscaler). AWS CloudWatch có thể gửi metrics đến Kubernetes thông qua Prometheus Adapter hoặc bạn có thể sử dụng AWS CloudWatch Container Insights để giám sát và tự động điều chỉnh số lượng pod.

### Sử dụng Prometheus Adapter với CloudWatch Metrics

Để triển khai tự động điều chỉnh số lượng pod dựa trên CloudWatch metrics, bạn cần thực hiện các bước sau:

1. **Cài đặt Prometheus và Prometheus Adapter**: Thu thập và chuyển đổi CloudWatch metrics thành Kubernetes custom metrics.
2. **Cấu hình HPA để sử dụng custom metrics**: Thiết lập HPA để sử dụng custom metrics từ Prometheus Adapter.

### Bước 1: Cài đặt Prometheus và Prometheus Adapter
#### Cài đặt Prometheus
1. **Cài đặt Helm (nếu chưa có)**:
   ```bash
   curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
   ```

2. **Thêm Helm repository cho Prometheus**:
   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```

3. **Cài đặt Prometheus**:
   ```bash
   helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
   ```

#### Cài đặt Prometheus Adapter
1. **Cài đặt Prometheus Adapter**:
   ```bash
   helm install prometheus-adapter prometheus-community/prometheus-adapter --namespace monitoring
   ```

#### Cấu hình Prometheus Adapter để sử dụng CloudWatch metrics
1. **Cài đặt `kubectl` và `aws` CLI (nếu chưa có)**.
2. **Cấu hình AWS CLI**:
   ```bash
   aws configure
   ```

3. **Cấu hình Prometheus để lấy metrics từ CloudWatch**:
   - Tạo file cấu hình Prometheus (`prometheus-config.yaml`):
     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: prometheus-config
       namespace: monitoring
     data:
       prometheus.yml: |
         global:
           scrape_interval: 60s
         scrape_configs:
           - job_name: 'aws-cloudwatch'
             metrics_path: /federate
             params:
               'match[]':
                 - '{__name__=~"^aws_.+"}'
             static_configs:
               - targets:
                 - 'cloudwatch-exporter.monitoring.svc:9106'
     ```

4. **Áp dụng cấu hình Prometheus**:
   ```bash
   kubectl apply -f prometheus-config.yaml
   ```

5. **Cài đặt CloudWatch Exporter**:
   - Tạo file deployment cho CloudWatch Exporter (`cloudwatch-exporter-deployment.yaml`):
     ```yaml
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: cloudwatch-exporter
       namespace: monitoring
     spec:
       replicas: 1
       selector:
         matchLabels:
           app: cloudwatch-exporter
       template:
         metadata:
           labels:
             app: cloudwatch-exporter
         spec:
           containers:
           - name: cloudwatch-exporter
             image: prom/cloudwatch-exporter:latest
             ports:
             - containerPort: 9106
             volumeMounts:
             - name: config-volume
               mountPath: /config
           volumes:
           - name: config-volume
             configMap:
               name: cloudwatch-config
     ```

6. **Tạo file cấu hình CloudWatch Exporter (`cloudwatch-config.yaml`)**:
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: cloudwatch-config
     namespace: monitoring
   data:
     config.yml: |
       region: <aws-region>
       metrics:
         - aws_namespace: AWS/SQS
           aws_metric_name: ApproximateNumberOfMessagesVisible
           aws_dimensions: [QueueName]
           aws_statistics: [Sum]
           range_seconds: 60
           period_seconds: 60
           delay_seconds: 0
           nil_to_zero: true
   ```

7. **Áp dụng các cấu hình**:
   ```bash
   kubectl apply -f cloudwatch-exporter-deployment.yaml
   kubectl apply -f cloudwatch-config.yaml
   ```

### Bước 2: Cấu hình HPA để sử dụng custom metrics
1. **Tạo file cấu hình HPA (`hpa.yaml`)**:
   ```yaml
   apiVersion: autoscaling/v2beta2
   kind: HorizontalPodAutoscaler
   metadata:
     name: sqs-consumer-hpa
     namespace: default
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: sqs-consumer
     minReplicas: 1
     maxReplicas: 10
     metrics:
     - type: External
       external:
         metric:
           name: aws_sqs_ApproximateNumberOfMessagesVisible_Sum
           selector:
             matchLabels:
               QueueName: <queue-name>
         target:
           type: Value
           value: 100
   ```

2. **Áp dụng cấu hình HPA**:
   ```bash
   kubectl apply -f hpa.yaml
   ```

### Tóm tắt
1. **Cài đặt Prometheus và Prometheus Adapter**: Thu thập và chuyển đổi CloudWatch metrics thành Kubernetes custom metrics.
2. **Cấu hình Prometheus để lấy metrics từ CloudWatch**: Sử dụng CloudWatch Exporter để thu thập metrics từ AWS CloudWatch.
3. **Cấu hình HPA để sử dụng custom metrics**: Thiết lập HPA để sử dụng custom metrics từ Prometheus Adapter.
