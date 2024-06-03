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

