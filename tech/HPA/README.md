## HPA
Để cấu hình Horizontal Pod Autoscaler (HPA) cho một pod nhận message trong Kubernetes, dựa trên số lượng message trong queue và tăng số lượng pod khi thời gian chờ message queue vượt quá 1 giây, bạn sẽ cần thực hiện các bước sau:

1. **Sử dụng Prometheus để giám sát số lượng message trong queue:**
   - Cài đặt Prometheus và Prometheus Adapter để cung cấp metrics cho HPA.
   - Thiết lập exporter để thu thập metrics từ RabbitMQ hoặc Kafka.

2. **Cấu hình HPA dựa trên custom metrics:**
   - Cấu hình HPA để scale pods dựa trên custom metrics từ Prometheus.

### Bước 1: Cài đặt Prometheus và Prometheus Adapter

**1.1. Cài đặt Prometheus:**
   - Sử dụng Helm để cài đặt Prometheus:
     ```bash
     helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
     helm repo update
     helm install prometheus prometheus-community/kube-prometheus-stack
     ```

**1.2. Cài đặt Prometheus Adapter:**
   - Thêm Helm chart repository cho Prometheus Adapter và cài đặt:
     ```bash
     helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
     helm repo update
     helm install prometheus-adapter prometheus-community/prometheus-adapter --namespace monitoring
     ```

### Bước 2: Thiết lập Exporter để thu thập metrics

**2.1. RabbitMQ Exporter:**
   - Cài đặt RabbitMQ exporter để thu thập metrics từ RabbitMQ:
     ```bash
     kubectl apply -f https://raw.githubusercontent.com/kbudde/rabbitmq_exporter/master/rabbitmq-exporter-deployment.yaml
     ```

**2.2. Kafka Exporter:**
   - Cài đặt Kafka exporter để thu thập metrics từ Kafka:
     ```bash
     kubectl apply -f https://raw.githubusercontent.com/danielqsj/kafka_exporter/master/kafka_exporter-deployment.yaml
     ```

### Bước 3: Cấu hình Prometheus Adapter để cung cấp custom metrics

**3.1. Tạo cấu hình custom-metrics.yaml cho Prometheus Adapter:**
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: custom-metrics-config
     namespace: monitoring
   data:
     config.yaml: |
       rules:
       - seriesQuery: 'rabbitmq_queue_messages{queue="your-queue-name"}'
         resources:
           template: <<.Resource>>
         name:
           matches: "^(.*)_total$"
           as: "queue_length"
         metricsQuery: 'sum(rate(rabbitmq_queue_messages[1m])) by (<<.GroupBy>>)'

       - seriesQuery: 'kafka_consumer_lag{topic="your-topic-name"}'
         resources:
           template: <<.Resource>>
         name:
           matches: "^(.*)_total$"
           as: "consumer_lag"
         metricsQuery: 'sum(rate(kafka_consumer_lag[1m])) by (<<.GroupBy>>)'

   ```

**3.2. Áp dụng cấu hình ConfigMap:**
   ```bash
   kubectl apply -f custom-metrics.yaml
   ```

### Bước 4: Cấu hình HPA dựa trên custom metrics

**4.1. Tạo cấu hình HPA cho pod nhận message:**
   ```yaml
   apiVersion: autoscaling/v2beta2
   kind: HorizontalPodAutoscaler
   metadata:
     name: message-consumer-hpa
     namespace: default
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: message-consumer
     minReplicas: 2
     maxReplicas: 10
     metrics:
     - type: Pods
       pods:
         metric:
           name: queue_length
         target:
           type: AverageValue
           averageValue: "10"
   ```

**4.2. Áp dụng cấu hình HPA:**
   ```bash
   kubectl apply -f message-consumer-hpa.yaml
   ```

### Tóm tắt
1. **Cài đặt Prometheus và Prometheus Adapter** để giám sát metrics.
2. **Thiết lập Exporter** để thu thập metrics từ RabbitMQ hoặc Kafka.
3. **Cấu hình Prometheus Adapter** để cung cấp custom metrics cho HPA.
4. **Cấu hình HPA** để scale pods dựa trên custom metrics từ Prometheus.

Như vậy, bạn đã có một hệ thống HA cho pod nhận message trong Kubernetes, tự động tăng số lượng pod khi thời gian chờ message queue vượt quá một giá trị nhất định.
## PROMETHEUS ADAPTER
Prometheus Adapter là một thành phần giúp tích hợp Prometheus với Kubernetes Horizontal Pod Autoscaler (HPA). Nó cung cấp các custom metrics từ Prometheus cho HPA để quyết định khi nào cần scale các pods. Đây là một giải pháp hữu ích để mở rộng HPA vượt ra ngoài các metrics tiêu chuẩn như CPU và bộ nhớ, cho phép sử dụng các metrics tùy chỉnh khác như độ trễ, số lượng tin nhắn trong queue, v.v.

### Tại sao sử dụng Prometheus Adapter?

1. **Custom Metrics:**
   - HPA mặc định chỉ hỗ trợ scaling dựa trên CPU và memory. Prometheus Adapter mở rộng khả năng này bằng cách cho phép sử dụng các metrics tùy chỉnh từ Prometheus.
   
2. **Tích hợp mạnh mẽ với Prometheus:**
   - Prometheus là một hệ thống giám sát mạnh mẽ và phổ biến. Việc tích hợp với Prometheus giúp tận dụng tất cả các metrics mà Prometheus thu thập được để quyết định scaling.

3. **Tăng cường tính linh hoạt:**
   - Có thể cấu hình HPA để sử dụng các metrics phù hợp với yêu cầu cụ thể của ứng dụng, chẳng hạn như số lượng tin nhắn trong hàng đợi, độ trễ của yêu cầu, hoặc bất kỳ metrics nào được Prometheus thu thập.

### Cách hoạt động của Prometheus Adapter

Prometheus Adapter hoạt động như một bridge giữa Prometheus và Kubernetes. Nó truy vấn Prometheus để lấy các metrics và chuyển đổi chúng thành định dạng mà Kubernetes HPA có thể hiểu được.

### Cài đặt và cấu hình Prometheus Adapter

1. **Cài đặt Prometheus Adapter:**
   - Bạn có thể cài đặt Prometheus Adapter sử dụng Helm:
     ```bash
     helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
     helm repo update
     helm install prometheus-adapter prometheus-community/prometheus-adapter --namespace monitoring
     ```

2. **Cấu hình Prometheus Adapter:**
   - Tạo một ConfigMap để cấu hình các rules cho Prometheus Adapter. Dưới đây là một ví dụ cấu hình:
     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: custom-metrics-config
       namespace: monitoring
     data:
       config.yaml: |
         rules:
         - seriesQuery: 'rabbitmq_queue_messages{queue="your-queue-name"}'
           resources:
             template: <<.Resource>>
           name:
             matches: "^(.*)_total$"
             as: "queue_length"
           metricsQuery: 'sum(rate(rabbitmq_queue_messages[1m])) by (<<.GroupBy>>)'

         - seriesQuery: 'kafka_consumer_lag{topic="your-topic-name"}'
           resources:
             template: <<.Resource>>
           name:
             matches: "^(.*)_total$"
             as: "consumer_lag"
           metricsQuery: 'sum(rate(kafka_consumer_lag[1m])) by (<<.GroupBy>>)'

     ```

3. **Áp dụng cấu hình ConfigMap:**
   ```bash
   kubectl apply -f custom-metrics-config.yaml
   ```

4. **Cấu hình HPA để sử dụng custom metrics:**
   - Tạo một Horizontal Pod Autoscaler sử dụng custom metrics:
     ```yaml
     apiVersion: autoscaling/v2beta2
     kind: HorizontalPodAutoscaler
     metadata:
       name: message-consumer-hpa
       namespace: default
     spec:
       scaleTargetRef:
         apiVersion: apps/v1
         kind: Deployment
         name: message-consumer
       minReplicas: 2
       maxReplicas: 10
       metrics:
       - type: Pods
         pods:
           metric:
             name: queue_length
           target:
             type: AverageValue
             averageValue: "10"
     ```

5. **Áp dụng cấu hình HPA:**
   ```bash
   kubectl apply -f message-consumer-hpa.yaml
   ```

### Tóm tắt
Prometheus Adapter giúp mở rộng khả năng của Kubernetes HPA bằng cách cung cấp các custom metrics từ Prometheus. Điều này cho phép bạn scale các pods dựa trên các metrics tùy chỉnh phù hợp với yêu cầu cụ thể của ứng dụng, mang lại tính linh hoạt và hiệu quả cao trong quản lý tài nguyên.