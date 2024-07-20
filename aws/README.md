## S3
- protect the S3 data from accidental deletion.
  -  Enable versioning on the S3 bucket.
  - Enable MFA Delete on the S3 bucket.
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
AWS Global Accelerator và Amazon CloudFront đều là các dịch vụ của AWS thiết kế để cải thiện hiệu suất và độ tin cậy của ứng dụng web, nhưng chúng phục vụ các mục đích khác nhau và hoạt động theo các cách khác nhau. Dưới đây là sự phân biệt giữa hai dịch vụ này:

### AWS Global Accelerator

#### Mục Đích
AWS Global Accelerator là một dịch vụ mạng được quản lý giúp cải thiện tính sẵn sàng và hiệu suất của các ứng dụng của bạn bằng cách định tuyến lưu lượng truy cập qua mạng toàn cầu AWS.

#### Hoạt Động
- **Địa chỉ IP tĩnh**: Global Accelerator cung cấp hai địa chỉ IP tĩnh bất kỳ để đại diện cho ứng dụng của bạn. Người dùng có thể kết nối với địa chỉ IP tĩnh này thay vì phải nhớ các địa chỉ IP thay đổi của ứng dụng.
- **Anycast**: Sử dụng địa chỉ IP anycast để định tuyến lưu lượng đến các vị trí gần nhất với người dùng cuối dựa trên mạng AWS toàn cầu.
- **Định tuyến thông minh**: Tự động chọn tuyến đường mạng tối ưu dựa trên độ trễ, tải và các yếu tố khác để cải thiện hiệu suất.
- **Tính sẵn sàng cao**: Chuyển hướng lưu lượng tới các vùng sẵn có (availability zones) khác khi có sự cố để đảm bảo tính liên tục của dịch vụ.

#### Use Cases
- Ứng dụng đa vùng (multi-region) cần cải thiện độ tin cậy và hiệu suất.
- Ứng dụng TCP và UDP yêu cầu định tuyến mạng nhanh chóng và tối ưu.
- Dịch vụ cần địa chỉ IP tĩnh và khả năng failover tự động giữa các vùng sẵn có.

### Amazon CloudFront

#### Mục Đích
Amazon CloudFront là một dịch vụ mạng phân phối nội dung (CDN) giúp tăng tốc việc phân phối các trang web tĩnh và động, bao gồm các tệp hình ảnh, video, tài liệu HTML, và các ứng dụng API thông qua các edge locations toàn cầu.

#### Hoạt Động
- **Edge Locations**: CloudFront có hàng trăm edge locations trên toàn thế giới để đưa nội dung đến gần người dùng cuối nhất.
- **Caching**: Lưu trữ tạm thời các nội dung phổ biến tại các edge locations để giảm thời gian tải trang và băng thông.
- **Origin Servers**: CloudFront có thể lấy nội dung từ các máy chủ gốc như Amazon S3, Amazon EC2 hoặc máy chủ bên ngoài.
- **TLS/SSL**: Cung cấp bảo mật với chứng chỉ SSL/TLS để mã hóa dữ liệu trong quá trình truyền.
- **Tính năng nâng cao**: Hỗ trợ nén Gzip/Brotli, điều khiển chi tiết truy cập nội dung, tùy chỉnh đáp ứng (Lambda@Edge), v.v.

#### Use Cases
- Phân phối nội dung tĩnh và động trên toàn cầu với độ trễ thấp.
- Ứng dụng web cần cải thiện hiệu suất tải trang.
- Streaming media (video/audio) với chất lượng cao và độ trễ thấp.
- Bảo mật và kiểm soát truy cập nội dung.

### So Sánh Chi Tiết

| **Tiêu chí**                | **AWS Global Accelerator**                     | **Amazon CloudFront**                                |
|-----------------------------|------------------------------------------------|-----------------------------------------------------|
| **Mục đích chính**          | Tăng cường tính sẵn sàng và hiệu suất mạng     | Phân phối nội dung toàn cầu                         |
| **Địa chỉ IP**              | Cung cấp địa chỉ IP tĩnh                       | Sử dụng domain name (CNAME)                         |
| **Cách hoạt động**          | Định tuyến thông minh dựa trên anycast         | Caching và phân phối nội dung từ các edge locations |
| **Loại lưu lượng**          | TCP và UDP                                     | HTTP và HTTPS                                       |
| **Cải thiện hiệu suất**     | Tối ưu hóa định tuyến trên mạng AWS toàn cầu   | Giảm độ trễ thông qua caching tại các edge          |
| **Sẵn sàng cao**            | Tự động chuyển hướng giữa các vùng             | Chuyển hướng tới edge location gần nhất             |
| **Use Cases**               | Ứng dụng đa vùng, địa chỉ IP tĩnh              | Phân phối nội dung web, streaming media             |

### Khi Nào Sử Dụng Cái Nào?

- **AWS Global Accelerator**:
  - Khi bạn cần tối ưu hóa lưu lượng mạng cho ứng dụng TCP/UDP.
  - Khi bạn cần địa chỉ IP tĩnh và failover tự động giữa các vùng AWS.
  - Khi ứng dụng của bạn trải dài trên nhiều vùng địa lý và bạn cần tối ưu hóa đường dẫn mạng.

- **Amazon CloudFront**:
  - Khi bạn cần phân phối nội dung tĩnh và động trên toàn cầu với hiệu suất cao.
  - Khi bạn cần caching để giảm tải cho các máy chủ gốc.
  - Khi bạn cần bảo mật HTTPS và kiểm soát truy cập chi tiết cho nội dung của mình.

Tóm lại, Global Accelerator là dịch vụ mạng định tuyến lưu lượng thông minh với IP tĩnh, trong khi CloudFront là CDN giúp tăng tốc phân phối nội dung web. Lựa chọn giữa hai dịch vụ này phụ thuộc vào yêu cầu cụ thể của ứng dụng và mục đích sử dụng của bạn.
## NETWORK FIREWALL
## Amazon QuickSight
-  QuickSight is used to created dashboard from S3, RDS, Redshift, Aurora, Athena, OpenSearch, Timestream
## AWS Config
- Aws config là service giúp chúng ta có thể kiểm tra đánh giá aws resources.
- Ví dụ aws config tạo rule là chỉ cho phép các ami nhất định thôi, nhưng nếu có ec2 nào ko dùng các ami quy định đó sẽ terminate đi.
## AWS system manager
- Quản lý các ec2, truy xuất ec2 bảo mật, chỉ cần ec2 có role SSM và có SSM agent.
##  Amazon Appflow
- AWS AppFlow là một dịch vụ tích hợp dữ liệu hoàn toàn quản lý, cho phép bạn truyền dữ liệu một cách an toàn giữa các ứng dụng SaaS (Software as a Service) như Salesforce, ServiceNow, Google Analytics, và các dịch vụ AWS như Amazon S3 và Amazon Redshift. Giả sử có 1 SAAS muốn  tranfer data đến s3 thì dùng appflow để tranfer.

## AWS Direct Connect
- AWS Direct Connect là một dịch vụ mạng cung cấp kết nối chuyên dụng, riêng tư giữa cơ sở hạ tầng của bạn và Amazon Web Services (AWS).
    1. Các bước sử dụng AWS Direct Connect
        Đăng ký dịch vụ: Đăng ký một kết nối thông qua AWS Management Console.
        Thiết lập kết nối vật lý: Thiết lập kết nối vật lý từ trung tâm dữ liệu của bạn đến một trong các địa điểm AWS Direct Connect.
        Cấu hình mạng: Cấu hình các tham số mạng như VLAN, BGP và IP trên thiết bị mạng của bạn để kết nối với AWS.
        Kích hoạt và kiểm tra kết nối: Sau khi thiết lập, kích hoạt và kiểm tra kết nối để đảm bảo nó hoạt động đúng.
- Ex: A company has an on-premises application that generates a large amount of time-sensitive data that is backed up to Amazon S3. The application has grown and there are user complaints about internet bandwidth limitations. A solutions architect needs to design a long-term solution that allows for both timely backups to Amazon S3 and with minimal impact on internet connectivity for internal users. ==> Establish a new AWS Direct Connect connection and direct backup traffic through this new connection. 

## AWS Macie
- Amazon Macie là một dịch vụ bảo mật và quyền riêng tư của AWS sử dụng machine learning và các kỹ thuật pattern matching để phát hiện và bảo vệ dữ liệu nhạy cảm trong AWS. Macie tự động xác định và phân loại dữ liệu nhạy cảm như thông tin nhận dạng cá nhân (PII), thông tin thẻ tín dụng, dữ liệu sức khỏe, và các loại dữ liệu nhạy cảm khác trong các tài khoản Amazon S3. Macie cung cấp các báo cáo và cảnh báo về các phát hiện bảo mật, giúp bạn nhanh chóng phát hiện và ứng phó với các sự cố bảo mật. Các cảnh báo có thể được tích hợp với Amazon CloudWatch, AWS Security Hub, và các công cụ bảo mật khác.
- EX:  The stores upload transaction data to the company through SFTP, and the data is processed and analyzed to generate new marketing offers. Some of the files can exceed 200 GB in size. Recently, the company discovered that some of the stores have uploaded files that contain personally identifiable information (PII) that should not have been included. The company wants administrators to be alerted if PII is shared again. The company also wants to automate remediation. What should a solutions architect do to meet these requirements with the LEAST development effort? ==> 
## Amazon Simple Email Service (Amazon SES) 
- Là dịch vụ gửi và nhận email, xác thực email được gửi từ các tên miền của các bạn, quản lý email bị trả lại (bounce) và phản hồi (complaints)
## AWS EventBridge 
- là dịch vụ quản lý sự kiện được quản lý bởi aws, phát hiện và xử lý sự kiện từ nhiều nguồn khác nhau như aws services, ứng dụng riêng, SAAS. Giúp kết nối ứng dụng với rất nhiều dịch vụ aws, cho phép để định nghĩa các quy tắc để lọc và định tuyện các sự kiện đến các mục tiêu như aws lambda, sqs, sns, dịch vụ bên thứ 3.
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
## AWS S3 TYPE
Amazon S3 (Simple Storage Service) cung cấp các lớp lưu trữ khác nhau để đáp ứng các nhu cầu khác nhau về hiệu suất, chi phí và truy cập dữ liệu. Dưới đây là các loại lớp lưu trữ S3 mà AWS cung cấp:

### 1. S3 Standard
- **Mô tả**: Đây là lớp lưu trữ mặc định của S3, được thiết kế cho dữ liệu thường xuyên truy cập.
- **Use cases**: Dữ liệu thường xuyên truy cập, các ứng dụng di động và web, phân phối nội dung.
- **Độ bền và tính khả dụng**: Độ bền 99.999999999% (11 chín) và tính khả dụng 99.99%.

### 2. S3 Intelligent-Tiering
- **Mô tả**: Tự động di chuyển dữ liệu giữa hai lớp lưu trữ truy cập thường xuyên và không thường xuyên dựa trên cách sử dụng.
- **Use cases**: Dữ liệu với mẫu truy cập không thể đoán trước.
- **Độ bền và tính khả dụng**: Độ bền 99.999999999% và tính khả dụng 99.9%.

### 3. S3 Standard-IA (Infrequent Access)
- **Mô tả**: Được thiết kế cho dữ liệu ít truy cập nhưng vẫn yêu cầu truy cập nhanh khi cần.
- **Use cases**: Sao lưu dài hạn, lưu trữ dữ liệu thường không truy cập nhưng vẫn cần truy cập nhanh.
- **Độ bền và tính khả dụng**: Độ bền 99.999999999% và tính khả dụng 99.9%.

### 4. S3 One Zone-IA
- **Mô tả**: Lưu trữ dữ liệu ít truy cập nhưng chỉ trong một vùng sẵn có duy nhất. Thấp hơn về chi phí so với S3 Standard-IA.
- **Use cases**: Dữ liệu có thể tái tạo dễ dàng hoặc dữ liệu không quan trọng cần truy cập không thường xuyên.
- **Độ bền và tính khả dụng**: Độ bền 99.999999999% và tính khả dụng 99.5%.

### 5. S3 Glacier
- **Mô tả**: Lưu trữ lạnh, chi phí thấp cho dữ liệu ít truy cập với thời gian truy cập từ vài phút đến vài giờ.
- **Use cases**: Lưu trữ dữ liệu lâu dài, sao lưu dữ liệu cũ, dữ liệu tuân thủ pháp lý.
- **Độ bền và tính khả dụng**: Độ bền 99.999999999% và tính khả dụng 99.99%.

### 6. S3 Glacier Deep Archive
- **Mô tả**: Lớp lưu trữ chi phí thấp nhất, dành cho dữ liệu hiếm khi truy cập, với thời gian truy cập từ 12 đến 48 giờ.
- **Use cases**: Lưu trữ dữ liệu rất lâu dài, tuân thủ pháp lý, dữ liệu lưu trữ không cần truy cập nhanh.
- **Độ bền và tính khả dụng**: Độ bền 99.999999999% và tính khả dụng 99.99%.

### 7. S3 Outposts
- **Mô tả**: Dịch vụ S3 được chạy trên cơ sở hạ tầng của khách hàng thông qua AWS Outposts để lưu trữ dữ liệu tại chỗ với cùng các API và tính năng như trong vùng AWS.
- **Use cases**: Ứng dụng yêu cầu lưu trữ cục bộ với sự tích hợp và quản lý của S3.
- **Độ bền và tính khả dụng**: Phụ thuộc vào cấu hình của AWS Outposts.

### Tóm tắt

| Loại Lưu Trữ             | Use cases                                       | Độ bền                    | Tính khả dụng          | Thời gian truy cập      |
|--------------------------|-------------------------------------------------|--------------------------|------------------------|-------------------------|
| **S3 Standard**          | Dữ liệu thường xuyên truy cập                   | 99.999999999%            | 99.99%                 | Gần như ngay lập tức    |
| **S3 Intelligent-Tiering**| Dữ liệu không thể đoán trước mẫu truy cập      | 99.999999999%            | 99.9%                  | Gần như ngay lập tức    |
| **S3 Standard-IA**       | Dữ liệu ít truy cập                             | 99.999999999%            | 99.9%                  | Gần như ngay lập tức    |
| **S3 One Zone-IA**       | Dữ liệu có thể tái tạo dễ dàng                 | 99.999999999%            | 99.5%                  | Gần như ngay lập tức    |
| **S3 Glacier**           | Lưu trữ lâu dài với truy cập ít                 | 99.999999999%            | 99.99%                 | Vài phút đến vài giờ    |
| **S3 Glacier Deep Archive**| Lưu trữ rất lâu dài với truy cập hiếm hoi    | 99.999999999%            | 99.99%                 | 12 đến 48 giờ           |
| **S3 Outposts**          | Lưu trữ cục bộ với tích hợp AWS                 | Phụ thuộc vào Outposts   | Phụ thuộc vào Outposts | Gần như ngay lập tức    |

Lựa chọn lớp lưu trữ nào phụ thuộc vào yêu cầu cụ thể của bạn về tần suất truy cập, chi phí và độ bền dữ liệu.
## CloudWatch and Cloud Trial
CloudWatch và CloudTrail là hai dịch vụ quản lý và giám sát quan trọng trong AWS. Dưới đây là thông tin chi tiết về cả hai:

### AWS CloudWatch

**Amazon CloudWatch** là một dịch vụ giám sát và quản lý được sử dụng để theo dõi các ứng dụng, tài nguyên hệ thống, và dịch vụ AWS trong môi trường đám mây của bạn. 

**Các tính năng chính:**
- **Giám sát tài nguyên:** Thu thập và theo dõi các số liệu (metrics) từ các dịch vụ AWS như EC2, RDS, DynamoDB, và các ứng dụng chạy trên AWS.
- **Log Management:** Thu thập và theo dõi các log từ các tài nguyên AWS và ứng dụng của bạn, sau đó bạn có thể tìm kiếm và phân tích chúng.
- **Alarms:** Thiết lập cảnh báo dựa trên các số liệu mà bạn đang giám sát để nhận thông báo khi có vấn đề xảy ra hoặc khi cần hành động.
- **Dashboards:** Tạo các bảng điều khiển tùy chỉnh để hiển thị dữ liệu số liệu và log theo thời gian thực.

**Ví dụ sử dụng:**
- Giám sát tình trạng hoạt động của các instance EC2, bao gồm CPU, Disk I/O, Network I/O.
- Thiết lập cảnh báo để thông báo khi mức sử dụng CPU vượt ngưỡng nhất định.
- Theo dõi các log từ ứng dụng của bạn để phát hiện và giải quyết các vấn đề kịp thời.

### AWS CloudTrail

**AWS CloudTrail** là một dịch vụ giúp bạn giám sát và ghi lại mọi hoạt động API được thực hiện trong tài khoản AWS của bạn. CloudTrail cung cấp lịch sử về các hành động này, cho phép bạn kiểm tra, phân tích và giám sát mọi thay đổi và hoạt động trong tài khoản của mình.

**Các tính năng chính:**
- **Logging API Calls:** Ghi lại tất cả các cuộc gọi API (bao gồm qua AWS Management Console, AWS SDKs, command line tools, và các dịch vụ AWS khác).
- **Tra cứu sự kiện:** Bạn có thể tìm kiếm và lọc các sự kiện cụ thể để tìm hiểu ai đã làm gì trong tài khoản của bạn.
- **S3 Buckets:** CloudTrail logs có thể được gửi đến Amazon S3 để lưu trữ dài hạn và phân tích sâu hơn.
- **Security and Compliance:** Giúp bạn tuân thủ các yêu cầu pháp lý và kiểm tra bảo mật bằng cách cung cấp một bản ghi đầy đủ về tất cả các hoạt động API.

**Ví dụ sử dụng:**
- Kiểm tra ai đã thực hiện thay đổi đối với một nhóm bảo mật hoặc thiết lập IAM trong tài khoản của bạn.
- Giám sát các hoạt động bất thường hoặc trái phép.
- Cung cấp thông tin chi tiết cho các cuộc kiểm toán và điều tra bảo mật.
## AWS Organization
### Ví dụ Quản Lý Phức Tạp Hơn với AWS Organizations

Để quản lý phức tạp hơn, bạn có thể sử dụng các tính năng nâng cao của AWS Organizations như kết hợp nhiều SCP, sử dụng Tag Policies, và quản lý quyền truy cập phức tạp cho các môi trường khác nhau. Dưới đây là một số ví dụ chi tiết:

#### Ví dụ 1: Quản lý môi trường đa lớp với SCP và Tag Policies

1. **Cấu trúc tổ chức:**
   - Tạo các OU: **Development**, **Testing**, **Production**, **Security**, **Finance**.

2. **Chính sách kiểm soát dịch vụ (SCP) cho các môi trường:**
   - SCP cho OU **Development**: Cho phép sử dụng tất cả các dịch vụ nhưng giới hạn quyền tạo các tài nguyên tốn kém.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": "*",
           "Resource": "*"
         },
         {
           "Effect": "Deny",
           "Action": [
             "ec2:RunInstances",
             "rds:CreateDBInstance"
           ],
           "Resource": "*",
           "Condition": {
             "StringEquals": {
               "ec2:InstanceType": ["t2.micro", "t2.small"]
             }
           }
         }
       ]
     }
     ```

   - SCP cho OU **Testing**: Chỉ cho phép truy cập vào các dịch vụ EC2, S3, và RDS.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "ec2:*",
             "s3:*",
             "rds:*"
           ],
           "Resource": "*"
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

   - SCP cho OU **Production**: Giới hạn quyền truy cập vào tài nguyên và dịch vụ dựa trên các tag cụ thể.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": "*",
           "Resource": "*",
           "Condition": {
             "StringEquals": {
               "aws:RequestTag/Environment": "Production"
             }
           }
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

3. **Tag Policies:**
   - Thiết lập các Tag Policies để đảm bảo rằng tất cả các tài nguyên trong môi trường Production được gán tag `Environment: Production`.

4. **Quản lý quyền hạn cho Security và Finance:**
   - SCP cho OU **Security**: Chỉ cho phép truy cập vào các dịch vụ bảo mật như IAM, GuardDuty.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "iam:*",
             "guardduty:*",
             "cloudtrail:*",
             "config:*"
           ],
           "Resource": "*"
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

   - SCP cho OU **Finance**: Chỉ cho phép truy cập vào các dịch vụ liên quan đến quản lý chi phí như Billing, Cost Explorer.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "aws-portal:*",
             "ce:*",
             "cur:*"
           ],
           "Resource": "*"
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

#### Ví dụ 2: Quản lý tài nguyên và quyền truy cập phức tạp cho nhiều dự án

1. **Cấu trúc tổ chức:**
   - Tạo các OU: **ProjectA**, **ProjectB**, **SharedServices**.

2. **Quản lý tài nguyên cho các dự án khác nhau:**
   - SCP cho OU **ProjectA**: Giới hạn truy cập vào các dịch vụ và tài nguyên thuộc ProjectA.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": "*",
           "Resource": "arn:aws:*:*:projectA:*"
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

   - SCP cho OU **ProjectB**: Tương tự, giới hạn truy cập vào các dịch vụ và tài nguyên thuộc ProjectB.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": "*",
           "Resource": "arn:aws:*:*:projectB:*"
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

3. **Quản lý quyền truy cập cho SharedServices:**
   - SCP cho OU **SharedServices**: Cho phép truy cập vào các dịch vụ và tài nguyên chung mà cả ProjectA và ProjectB cần sử dụng.
     ```json
     {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Action": [
             "s3:*",
             "cloudwatch:*",
             "vpc:*"
           ],
           "Resource": "*"
         },
         {
           "Effect": "Deny",
           "Action": "*",
           "Resource": "*"
         }
       ]
     }
     ```

4. **Thiết lập phân quyền nâng cao:**
   - Tạo IAM Roles cho từng dự án và gán các chính sách phù hợp để kiểm soát chi tiết quyền truy cập của từng người dùng và nhóm.

5. **Sử dụng Tag Policies và SCP nâng cao:**
   - Kết hợp Tag Policies để quản lý và kiểm soát tài nguyên dựa trên các tag như `Project: ProjectA` hoặc `Project: ProjectB`.
   - Sử dụng các SCP phức tạp hơn để kiểm soát chi tiết hơn dựa trên các tag này.

Bằng cách sử dụng các tính năng nâng cao của AWS Organizations, bạn có thể tạo ra một môi trường quản lý tài nguyên và quyền truy cập rất phức tạp, nhưng vẫn đảm bảo tính bảo mật và hiệu quả trong việc sử dụng tài nguyên AWS. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần hỗ trợ thêm, hãy cho tôi biết!
## AWS SECURITY
AWS cung cấp một loạt các dịch vụ bảo mật để giúp bảo vệ cơ sở hạ tầng, ứng dụng, và dữ liệu của bạn. Dưới đây là một số dịch vụ bảo mật nổi bật của AWS:

1. **AWS Identity and Access Management (IAM)**: Cho phép bạn kiểm soát quyền truy cập vào các dịch vụ và tài nguyên AWS của bạn.

2. **Amazon GuardDuty**: Dịch vụ phát hiện mối đe dọa thông minh, liên tục giám sát và phân tích các log dữ liệu để phát hiện hoạt động đáng ngờ và các mối đe dọa tiềm ẩn.

3. **AWS Shield**: Bảo vệ chống lại các cuộc tấn công DDoS (Distributed Denial of Service) với hai phiên bản: AWS Shield Standard và AWS Shield Advanced.

4. **AWS WAF (Web Application Firewall)**: Giúp bảo vệ các ứng dụng web của bạn khỏi các cuộc tấn công phổ biến như SQL injection và cross-site scripting.

5. **AWS Key Management Service (KMS)**: Quản lý và bảo vệ khóa mã hóa cho các ứng dụng và dịch vụ của bạn.

6. **Amazon Macie**: Dịch vụ bảo mật dữ liệu sử dụng machine learning để phát hiện, phân loại và bảo vệ dữ liệu nhạy cảm của bạn.

7. **AWS CloudTrail**: Ghi lại các hành động gọi API cho tài khoản AWS của bạn, cung cấp thông tin chi tiết về người đã thực hiện hành động gì, khi nào và từ đâu.

8. **AWS Config**: Cung cấp khả năng theo dõi cấu hình tài nguyên AWS của bạn và cảnh báo khi có sự thay đổi không mong muốn.

9. **AWS Certificate Manager (ACM)**: Giúp bạn dễ dàng quản lý và triển khai các chứng chỉ SSL/TLS cho các trang web và ứng dụng của bạn.

10. **AWS Secrets Manager**: Giúp bạn bảo vệ truy cập vào các thông tin nhạy cảm như mật khẩu, khóa API, và các thông tin đăng nhập khác bằng cách lưu trữ và quản lý chúng một cách an toàn.

11. **AWS Security Hub**: Cung cấp một cái nhìn tổng thể về trạng thái bảo mật của bạn trong AWS, giúp bạn xác định và giải quyết các vấn đề bảo mật một cách hiệu quả.

12. **Amazon Inspector**: Dịch vụ quét các lỗ hổng bảo mật trong các phiên bản EC2 và ứng dụng của bạn.

Sử dụng các dịch vụ này, bạn có thể xây dựng một môi trường AWS an toàn, tuân thủ các tiêu chuẩn và quy định bảo mật quốc tế.
## Resource base policy
Trong AWS, một số dịch vụ hỗ trợ các "resource-based policies" (chính sách dựa trên tài nguyên) để kiểm soát quyền truy cập vào các tài nguyên cụ thể. Các chính sách này được gắn trực tiếp vào tài nguyên và chỉ định ai (tài khoản AWS, người dùng, vai trò, nhóm, v.v.) có thể thực hiện những hành động nào trên tài nguyên đó. Dưới đây là một số dịch vụ phổ biến của AWS có hỗ trợ resource-based policies:

### 1. **Amazon S3 (Simple Storage Service)**
- Bạn có thể gắn các chính sách vào bucket để kiểm soát quyền truy cập đối với các đối tượng (objects) trong bucket đó.

### 2. **AWS Lambda**
- Chính sách dựa trên tài nguyên có thể được gắn vào hàm Lambda để chỉ định ai có thể thực hiện các hành động như `invoke` hàm.

### 3. **Amazon SNS (Simple Notification Service)**
- Chính sách có thể được gắn vào chủ đề SNS để kiểm soát quyền truy cập vào các chủ đề này.

### 4. **Amazon SQS (Simple Queue Service)**
- Chính sách có thể được gắn vào hàng đợi SQS để kiểm soát quyền truy cập vào các hàng đợi này.

### 5. **Amazon ECR (Elastic Container Registry)**
- Bạn có thể gắn các chính sách vào repository để kiểm soát quyền truy cập đối với các hình ảnh container.

### 6. **AWS KMS (Key Management Service)**
- Chính sách dựa trên tài nguyên có thể được gắn vào key KMS để kiểm soát quyền truy cập vào các khóa mã hóa.

### 7. **AWS CodeBuild**
- Chính sách có thể được gắn vào các dự án CodeBuild để kiểm soát quyền truy cập vào các dự án này.

### 8. **AWS CodeArtifact**
- Chính sách có thể được gắn vào repository để kiểm soát quyền truy cập vào các repository này.

### 9. **AWS Step Functions**
- Chính sách có thể được gắn vào các state machine để kiểm soát quyền truy cập vào các state machine này.

### 10. **AWS Glue**
- Chính sách có thể được gắn vào các Data Catalog để kiểm soát quyền truy cập vào các dữ liệu trong Glue.

### 11. **AWS IAM Roles**
- Các vai trò IAM có thể có các chính sách dựa trên tài nguyên để kiểm soát ai có thể giả mạo (assume) vai trò đó.

### 12. **Amazon EFS (Elastic File System)**
- Chính sách có thể được gắn vào hệ thống file để kiểm soát quyền truy cập vào các hệ thống file này.

### 13. **AWS Secrets Manager**
- Chính sách có thể được gắn vào bí mật để kiểm soát quyền truy cập vào các bí mật này.

### 14. **AWS Service Catalog**
- Chính sách có thể được gắn vào danh mục dịch vụ để kiểm soát quyền truy cập vào các danh mục này.

### 15. **Amazon DynamoDB**
- Chính sách có thể được gắn vào bảng để kiểm soát quyền truy cập vào các bảng này.