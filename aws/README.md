## STORAGE
- Có 3 loại cloud storage
    - Object storage: là storage có khả năng mở rộng linh hoạt, lưu trữ mọi loại dữ liệu ( dữ liệu phi cấu trúc, binary, blobs), kích thước lớn.
    - File storage : lưu file nhiều ứng dụng truy cập, dạng share file, network attached storage.
    - Block storage máy chủ cần bộ lưu trữ riêng, độ trể thấp
- S3 : được thiết kế để lưu trữ dung lượng lớn, giá thấp, khả năng mở rộng cao, dữ liệu được mã hoá (mã hoá ở client side và service side)
    - s3 standard: độ trể thấp, cần truy xuất nhanh, thường xuyên truy xuất dữ liệu
    - s3 standard-IA: sử dụng không thường xuyên, và khi truy xuất sẽ nhanh, thường dùng là kho dữ liệu sao lưu. Tiết kiệm tiền
    - s3 onezone IA: như s3 IA nhưng giá thấp hơn, nằm trên 1 zone.
    - s3 interlligent-tiering: khác xác định được lượng truy xuất, và muốn tiết kiệm giá
    - AWS GLACIER and Glacer deep: data được đóng băng trong 1 khoảng thời gian. data sẽ được lấy nhanh khi cần, giá rẽ.
- S3 Transfer Acceleration : truyền tải dữ liệu lên s3 nhanh hơn
- EBS : Cho dữ liệu ở mức độ truy cập cao, bảo mật dữ liệu, muốn move az thì sẽ tạo snapshot vào move qua az khác
## RESIZE EBS ZERO DOWTIME
- check free disk space available: df -h
- list all block devide: lsblk
- extend size: growpart /dev/xvda 1 ( phụ thuộc type file system)
## Athena
- athena là dịch vụ query tương tác của aws giúp mình dễ dàng phân tích data trực tiếp trong S3 và sử dụng SQL. chỉ cần chỉ chỉ định bucket s3 và sử dụng standard sql để run ad-hoc queries và sẽ có kết quả trong vài giây
## Kinesis Data Streams
- là dịch vụ aws để thu thập và xử lý luồng bản ghi lớn trong thời gian thực
- MFA 
## Global Accelerator
- cải thiện ộ sẳn sàng, bảo mật, hiệu năng của ứng dụng ra internet. giúp xem là khi user call api sẽ gọi đến server nào. dựa vào độ trể. server nào có độ trể thấp hơn sẽ call đến đó. Cách hoạt động gần giống với cloudfront. nhưng cho endpoint theo ec2, loadbalance, ElasticIP...
- khi tạo 1 GA thì sẽ giúp chúng ta điều hướng traffic đến nhiều server trên nhiều region, 
- GA sẽ cung cấp 1 DNS và thêm 2 static IP.
## Explanation - AWS Global Accelerator vs CloudFront

• They both use the AWS global network and its edge locations around the world
• Both services integrate with AWS Shield for DDoS protection.
• CloudFront
• Improves performance for both cacheable content (such as images and videos)
• Dynamic content (such as API acceleration and dynamic site delivery)
• Content is served at the edge
• Global Accelerator
• Improves performance for a wide range of applications over TCP or UDP
• Proxying packets at the edge to applications running in one or more AWS Regions.
• Good fit for non-HTTP use cases, such as gaming (UDP), IoT (MQTT), or Voice over IP
• Good for HTTP use cases that require static IP addresses
• Good for HTTP use cases that required deterministic, fast regional failover
## NETWORK FIREWALL
## Amazon QuickSight
-  QuickSight is used to created dashboard from S3, RDS, Redshift, Aurora, Athena, OpenSearch, Timestream
## AWS Config
- Aws config là service giúp chúng ta có thể kiểm tra đánh giá aws resources.
- Ví dụ aws config tạo rule là chỉ cho phép các ami nhất định thôi, nhưng nếu có ec2 nào ko dùng các ami quy định đó sẽ terminate đi.
## AWS system manager
- Quản lý các ec2, truy xuất ec2 bảo mật, chỉ cần ec2 có role SSM và có SSM agent.
##  Amazon Appflow
- AWS AppFlow là một dịch vụ tích hợp dữ liệu hoàn toàn quản lý, cho phép bạn truyền dữ liệu một cách an toàn giữa các ứng dụng SaaS (Software as a Service) như Salesforce, ServiceNow, Google Analytics, và các dịch vụ AWS như Amazon S3 và Amazon Redshift.
## AWS Direct Connect
- AWS Direct Connect là một dịch vụ mạng cung cấp kết nối chuyên dụng, riêng tư giữa cơ sở hạ tầng của bạn và Amazon Web Services (AWS).
    1. Các bước sử dụng AWS Direct Connect
        Đăng ký dịch vụ: Đăng ký một kết nối thông qua AWS Management Console.
        Thiết lập kết nối vật lý: Thiết lập kết nối vật lý từ trung tâm dữ liệu của bạn đến một trong các địa điểm AWS Direct Connect.
        Cấu hình mạng: Cấu hình các tham số mạng như VLAN, BGP và IP trên thiết bị mạng của bạn để kết nối với AWS.
        Kích hoạt và kiểm tra kết nối: Sau khi thiết lập, kích hoạt và kiểm tra kết nối để đảm bảo nó hoạt động đúng.

## AWS Macie
- Amazon Macie là một dịch vụ bảo mật và quyền riêng tư của AWS sử dụng machine learning và các kỹ thuật pattern matching để phát hiện và bảo vệ dữ liệu nhạy cảm trong AWS. Macie tự động xác định và phân loại dữ liệu nhạy cảm như thông tin nhận dạng cá nhân (PII), thông tin thẻ tín dụng, dữ liệu sức khỏe, và các loại dữ liệu nhạy cảm khác trong các tài khoản Amazon S3. Macie cung cấp các báo cáo và cảnh báo về các phát hiện bảo mật, giúp bạn nhanh chóng phát hiện và ứng phó với các sự cố bảo mật. Các cảnh báo có thể được tích hợp với Amazon CloudWatch, AWS Security Hub, và các công cụ bảo mật khác.
## Amazon Simple Email Service (Amazon SES) 
- Là dịch vụ gửi và nhận email, xác thực email được gửi từ các tên miền của các bạn, quản lý email bị trả lại (bounce) và phản hồi (complaints)
## AWS EventBridge 
- là dịch vụ quản lý sự
 kiện được quản lý bởi aws, phát hiện và xử lý sự kiện từ nhiều nguồn khác nhau như aws services, ứng dụng riêng, SAAS. Giúp kết nối ứng dụng với rất nhiều dịch vụ aws, cho phép để định nghĩa các quy tắc để lọc và định tuyện các sự kiện đến các mục tiêu như aws lambda, sqs, sns, dịch vụ bên thứ 3.
## AWS STORAGE
AWS cung cấp nhiều loại dịch vụ lưu trữ (storage) khác nhau để đáp ứng các nhu cầu đa dạng của người dùng. Dưới đây là phân loại và mô tả chi tiết về các loại lưu trữ chính trong AWS:

### 1. Amazon S3 (Simple Storage Service)

**Loại lưu trữ**: Object Storage

**Mô tả**:
- **Lưu trữ đối tượng**: Lưu trữ dữ liệu dưới dạng các đối tượng trong các bucket. Mỗi đối tượng bao gồm dữ liệu, metadata, và một khóa duy nhất.
- **Khả năng mở rộng và độ bền cao**: Được thiết kế để cung cấp độ bền 99.999999999% (11 chín) và độ sẵn sàng cao.
- **Use cases**: Lưu trữ và phân phối nội dung, sao lưu và khôi phục, lưu trữ dữ liệu lớn, và phân tích dữ liệu.

**Tính năng nổi bật**:
- **S3 Glacier**: Lớp lưu trữ chi phí thấp cho lưu trữ dữ liệu dài hạn và ít truy cập.
- **S3 Intelligent-Tiering**: Tự động di chuyển dữ liệu giữa các lớp lưu trữ để tối ưu chi phí.
- **Versioning**: Giúp quản lý và bảo vệ dữ liệu bằng cách lưu trữ nhiều phiên bản của các đối tượng.

### 2. Amazon EBS (Elastic Block Store)

**Loại lưu trữ**: Block Storage

**Mô tả**:
- **Lưu trữ khối**: Cung cấp các volume lưu trữ có thể gắn vào các instance EC2 như các ổ đĩa cứng.
- **Độ bền và độ sẵn sàng cao**: Dữ liệu được sao chép trong cùng một Availability Zone để bảo vệ khỏi lỗi phần cứng.

**Use cases**: Lưu trữ dữ liệu ứng dụng, cơ sở dữ liệu, và lưu trữ thường xuyên truy cập.

**Tính năng nổi bật**:
- **Snapshots**: Tạo bản sao lưu dữ liệu EBS để phục hồi hoặc nhân bản.
- **Provisioned IOPS**: Đảm bảo hiệu suất cao với số lượng IOPS cố định.

### 3. Amazon EFS (Elastic File System)

**Loại lưu trữ**: File Storage

**Mô tả**:
- **Lưu trữ file**: Hệ thống file phân tán và mở rộng, cung cấp truy cập file theo giao thức NFS.
- **Khả năng mở rộng tự động**: Tự động mở rộng và thu nhỏ dựa trên lượng dữ liệu lưu trữ.

**Use cases**: Lưu trữ dữ liệu cần truy cập từ nhiều phiên làm việc EC2, ứng dụng yêu cầu chia sẻ file, và lưu trữ home directories.

**Tính năng nổi bật**:
- **Scalable performance**: Điều chỉnh hiệu suất theo yêu cầu của ứng dụng.
- **Managed service**: AWS quản lý toàn bộ cơ sở hạ tầng.

### 4. AWS FSx

**Loại lưu trữ**: Managed File Storage

**Mô tả**:
- **Amazon FSx for Windows File Server**: Cung cấp hệ thống file Windows native với hỗ trợ đầy đủ các tính năng của Windows File Server.
- **Amazon FSx for Lustre**: Hệ thống file hiệu năng cao được tối ưu hóa cho các khối lượng công việc đòi hỏi hiệu suất như HPC (High Performance Computing).

**Use cases**: Ứng dụng Windows-based, dữ liệu máy tính hiệu năng cao, và phân tích dữ liệu.

### 5. AWS Storage Gateway

**Loại lưu trữ**: Hybrid Cloud Storage

**Mô tả**:
- **Gateway Service**: Kết nối các môi trường tại chỗ với lưu trữ đám mây AWS, hỗ trợ các giao thức như file, volume, và tape.

**Use cases**: Di chuyển dữ liệu đám mây, sao lưu và khôi phục dữ liệu tại chỗ, và mở rộng lưu trữ tại chỗ.

**Tính năng nổi bật**:
- **Hybrid integration**: Tích hợp liền mạch với các dịch vụ lưu trữ tại chỗ và đám mây.
- **Multiple modes**: Hỗ trợ File Gateway, Volume Gateway, và Tape Gateway.

### Tóm Tắt

| Loại Lưu Trữ         | Loại Hình         | Use Cases Chính                                    | Tính Năng Nổi Bật                |
|----------------------|-------------------|----------------------------------------------------|-----------------------------------|
| Amazon S3            | Object Storage    | Lưu trữ và phân phối nội dung, sao lưu, phân tích dữ liệu | S3 Glacier, S3 Intelligent-Tiering, Versioning |
| Amazon EBS           | Block Storage     | Lưu trữ dữ liệu ứng dụng, cơ sở dữ liệu            | Snapshots, Provisioned IOPS      |
| Amazon EFS           | File Storage      | Truy cập file từ nhiều instance EC2                | Scalable performance, Managed service |
| AWS FSx              | Managed File Storage | Ứng dụng Windows, HPC, phân tích dữ liệu            | Windows File Server, Lustre      |
| AWS Storage Gateway  | Hybrid Cloud Storage | Di chuyển dữ liệu đám mây, sao lưu, mở rộng lưu trữ | Hybrid integration, Multiple modes |

AWS cung cấp nhiều loại dịch vụ lưu trữ khác nhau để phù hợp với nhu cầu đa dạng của người dùng, từ lưu trữ đối tượng và khối đến lưu trữ file và hybrid cloud. Mỗi loại dịch vụ có những tính năng và lợi ích riêng, giúp bạn lựa chọn giải pháp lưu trữ phù hợp nhất cho ứng dụng và dữ liệu của mình.

## Phân biệt các loại storage
Dưới đây là phân biệt giữa các loại lưu trữ khối (block storage), lưu trữ tệp (file storage), và lưu trữ đối tượng (object storage), cùng với các ví dụ thực tế:

### Block Storage

**Mô tả**:
- **Lưu trữ khối** là loại lưu trữ cấp thấp nhất, dữ liệu được lưu trữ trong các khối (blocks). Mỗi khối có một địa chỉ duy nhất, nhưng không chứa metadata cao hơn như trong lưu trữ đối tượng.
- Các khối này có thể được định dạng với một hệ thống file và gắn vào một hệ thống như một ổ đĩa cứng.

**Use cases**:
- Cơ sở dữ liệu.
- Hệ điều hành và ứng dụng cần hiệu suất cao.
- Lưu trữ thường xuyên truy cập với yêu cầu IOPS (Input/Output Operations Per Second) cao.

**Ví dụ thực tế**:
- **Amazon EBS (Elastic Block Store)**: Dịch vụ lưu trữ khối trên AWS, được sử dụng phổ biến để lưu trữ dữ liệu của các instance EC2.

### File Storage

**Mô tả**:
- **Lưu trữ tệp** lưu trữ dữ liệu dưới dạng các tệp trong một hệ thống file, và dữ liệu có thể được truy cập qua các giao thức như NFS (Network File System) hoặc SMB (Server Message Block).
- Dễ dàng chia sẻ dữ liệu giữa nhiều máy chủ và người dùng.

**Use cases**:
- Chia sẻ file giữa các máy chủ.
- Lưu trữ home directories cho người dùng.
- Ứng dụng cần truy cập tệp đồng thời từ nhiều nguồn.

**Ví dụ thực tế**:
- **Amazon EFS (Elastic File System)**: Hệ thống file phân tán và mở rộng tự động của AWS, hỗ trợ giao thức NFS.
- **Amazon FSx**: Dịch vụ lưu trữ tệp được quản lý, có hai biến thể: FSx for Windows File Server và FSx for Lustre.

### Object Storage

**Mô tả**:
- **Lưu trữ đối tượng** lưu trữ dữ liệu dưới dạng các đối tượng. Mỗi đối tượng bao gồm dữ liệu, metadata, và một định danh duy nhất (unique identifier).
- Không có cấu trúc thư mục như file storage, thay vào đó dữ liệu được tổ chức trong các buckets.

**Use cases**:
- Lưu trữ và phân phối nội dung đa phương tiện.
- Sao lưu và lưu trữ dài hạn.
- Lưu trữ dữ liệu lớn cho phân tích và máy học.

**Ví dụ thực tế**:
- **Amazon S3 (Simple Storage Service)**: Dịch vụ lưu trữ đối tượng trên AWS, được thiết kế để cung cấp độ bền và khả năng mở rộng cao.
- **Amazon S3 Glacier**: Lớp lưu trữ chi phí thấp cho lưu trữ dữ liệu dài hạn và ít truy cập.

### So Sánh Tóm Tắt

| Tiêu Chí         | Block Storage                         | File Storage                            | Object Storage                                |
|------------------|---------------------------------------|-----------------------------------------|-----------------------------------------------|
| Cấu trúc         | Khối                                  | Tệp                                      | Đối tượng (objects)                           |
| Truy cập         | Qua hệ điều hành, được gắn như ổ đĩa  | Qua giao thức file (NFS, SMB)           | Qua API HTTP (RESTful)                        |
| Use Cases        | Cơ sở dữ liệu, hệ điều hành           | Chia sẻ tệp, home directories            | Lưu trữ đa phương tiện, sao lưu, dữ liệu lớn  |
| Tính năng        | IOPS cao, định dạng hệ thống file     | Chia sẻ dữ liệu, truy cập đồng thời      | Metadata phong phú, khả năng mở rộng cao      |
| Ví dụ AWS        | Amazon EBS                            | Amazon EFS, Amazon FSx                  | Amazon S3, Amazon S3 Glacier                  |

### Ví Dụ Thực Tế

1. **Block Storage**:
   - **Amazon EBS**: Được sử dụng để lưu trữ dữ liệu của các instance EC2, như dữ liệu cơ sở dữ liệu hoặc tệp hệ điều hành.

2. **File Storage**:
   - **Amazon EFS**: Được sử dụng để lưu trữ home directories hoặc chia sẻ tệp giữa nhiều máy chủ EC2.
   - **Amazon FSx for Windows File Server**: Lưu trữ và chia sẻ dữ liệu cho các ứng dụng Windows-based.

3. **Object Storage**:
   - **Amazon S3**: Lưu trữ và phân phối nội dung web, sao lưu dữ liệu, và lưu trữ dữ liệu lớn để phân tích.
   - **Amazon S3 Glacier**: Lưu trữ dữ liệu dài hạn như tài liệu lưu trữ và sao lưu lịch sử.

Mỗi loại lưu trữ có những ưu và nhược điểm riêng, phù hợp với các nhu cầu sử dụng khác nhau. Sự lựa chọn giữa chúng phụ thuộc vào yêu cầu cụ thể về hiệu suất, chi phí, và khả năng mở rộng của ứng dụng và dữ liệu.