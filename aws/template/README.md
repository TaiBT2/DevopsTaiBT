## Template 1
Dưới đây là một kiến trúc mẫu cho việc triển khai một ứng dụng web phức tạp sử dụng các dịch vụ của AWS:

### 1. VPC (Virtual Private Cloud)
- **VPC**: Tạo một VPC để chứa tất cả các tài nguyên AWS.
- **Subnets**: Chia VPC thành các subnet công cộng và riêng tư ở ít nhất hai availability zones (AZs) để đảm bảo khả năng chịu lỗi.
  - **Public Subnets**: Chứa các tài nguyên cần truy cập trực tiếp từ internet (như Load Balancer).
  - **Private Subnets**: Chứa các tài nguyên không cần truy cập trực tiếp từ internet (như EC2 instances, RDS).

### 2. IAM (Identity and Access Management)
- **IAM Roles & Policies**: Tạo các IAM roles và policies cho các dịch vụ như EC2, Lambda, RDS, và EKS để quản lý quyền truy cập.

### 3. EC2 (Elastic Compute Cloud)
- **Auto Scaling Group**: Tạo Auto Scaling Group cho các EC2 instances để đảm bảo ứng dụng có thể mở rộng linh hoạt theo nhu cầu.
- **Security Groups**: Tạo các security groups để quản lý truy cập vào EC2 instances.

### 4. Load Balancer (LB)
- **Application Load Balancer (ALB)**: Tạo ALB để phân phối lưu lượng truy cập đến các EC2 instances hoặc Kubernetes pods trong EKS.

### 5. EKS (Elastic Kubernetes Service)
- **EKS Cluster**: Tạo một EKS cluster để quản lý các container ứng dụng.
- **Node Groups**: Tạo các node groups cho EKS cluster.

### 6. S3 (Simple Storage Service)
- **S3 Buckets**: Tạo các S3 buckets để lưu trữ tĩnh dữ liệu, backup, và log files.

### 7. RDS (Relational Database Service)
- **RDS Instances**: Tạo một hoặc nhiều RDS instances (MySQL, PostgreSQL, etc.) cho cơ sở dữ liệu.
- **Subnets**: Đặt RDS instances trong các private subnets.

### 8. Lambda
- **Lambda Functions**: Tạo các Lambda functions để thực hiện các tác vụ không đồng bộ hoặc cron jobs.
- **Triggers**: Cấu hình EventBridge để kích hoạt Lambda functions khi có sự kiện cụ thể.

### 9. EventBridge
- **Event Rules**: Tạo các event rules để quản lý các sự kiện từ các dịch vụ khác nhau và kích hoạt các Lambda functions hoặc các mục tiêu khác.

### 10. CloudWatch
- **Monitoring**: Sử dụng CloudWatch để giám sát các tài nguyên AWS và thiết lập các alarms.
- **Logs**: Cấu hình CloudWatch Logs để lưu trữ log từ các EC2 instances, Lambda functions, và EKS pods.

### 11. Athena
- **Query S3 Data**: Sử dụng Athena để truy vấn dữ liệu được lưu trữ trong S3.

### 12. ACM (AWS Certificate Manager)
- **SSL Certificates**: Sử dụng ACM để quản lý SSL/TLS certificates cho các Load Balancers và các ứng dụng web.

### Kiến trúc tổng quan
```plaintext
                           Internet
                               |
                             ALB (Public Subnet)
                          /      |      \
         Private Subnet  EC2 Instances  EKS Nodes  Private Subnet
                          \      |      /
                            RDS Instances (Private Subnet)
                            /             \
         S3 Buckets (Private Subnet)    Lambda Functions (EventBridge Triggered)
                          |                |
                CloudWatch Logs       CloudWatch Monitoring
                          |                |
                       IAM Roles & Policies
                          |                |
                Athena Queries (S3 Data)   ACM (SSL/TLS Certificates)
```

### Giải thích chi tiết:
- **VPC**: Tạo một VPC duy nhất với các subnets công cộng và riêng tư để tổ chức các tài nguyên AWS.
- **IAM**: Tạo các IAM roles và policies để kiểm soát quyền truy cập của từng dịch vụ.
- **EC2 và EKS**: Chạy các ứng dụng trên EC2 instances hoặc Kubernetes pods trong EKS cluster.
- **Load Balancer**: Sử dụng ALB để phân phối lưu lượng truy cập tới các ứng dụng.
- **S3**: Lưu trữ dữ liệu tĩnh và log files.
- **RDS**: Quản lý cơ sở dữ liệu quan hệ trong các private subnets.
- **Lambda**: Thực hiện các tác vụ không đồng bộ hoặc theo lịch.
- **EventBridge**: Quản lý và kích hoạt các sự kiện cho các Lambda functions.
- **CloudWatch**: Giám sát và ghi log từ các tài nguyên AWS.
- **Athena**: Truy vấn dữ liệu lưu trữ trong S3.
- **ACM**: Quản lý SSL/TLS certificates để bảo mật giao tiếp mạng.

Kiến trúc này cung cấp một nền tảng mạnh mẽ, an toàn và linh hoạt để phát triển và triển khai các ứng dụng web phức tạp trên AWS.