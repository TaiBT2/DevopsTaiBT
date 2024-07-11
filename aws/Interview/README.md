## Q&A

### Câu hỏi về Kiến thức chuyên môn AWS

1. **Tại sao bạn nên sử dụng AWS cho dự án của bạn?**
2. **Giải thích sự khác biệt giữa EC2 và Lambda. Khi nào bạn nên sử dụng mỗi dịch vụ này?**
3. **Làm thế nào để giảm thiểu chi phí sử dụng AWS trong một dự án lớn?**
4. **Bạn đã sử dụng và triển khai các dịch vụ như CloudFormation, Terraform hay cả hai? So sánh và lựa chọn dịch vụ nào trong từng trường hợp?**
5. **Làm thế nào để thiết kế một hệ thống chịu lỗi cao (highly available) trên AWS? Nêu và giải thích các thành phần chính.**
6. **Giải thích cách bạn sử dụng AWS CloudWatch để giám sát và báo động cho hệ thống của bạn.**
7. **Bạn đã sử dụng dịch vụ Auto Scaling trên AWS chưa? Nếu có, làm thế nào để cấu hình và triển khai nó?**
8. **Nói về kinh nghiệm của bạn trong việc cấu hình và quản lý mạng ảo riêng (VPC) trên AWS.**
9. **Làm thế nào để đảm bảo bảo mật dữ liệu trên AWS? Nêu các giải pháp và dịch vụ bạn đã sử dụng.**
10. **Bạn đã sử dụng các dịch vụ như RDS, DynamoDB, Elasticsearch trên AWS chưa? Làm thế nào để lựa chọn giữa các dịch vụ cơ sở dữ liệu khác nhau?**

### Câu hỏi về Kinh nghiệm và Kỹ năng

1. **Hãy cho chúng tôi biết về một dự án AWS phức tạp mà bạn đã tham gia. Bạn đã đối mặt với thách thức gì và giải quyết chúng như thế nào?**
2. **Làm thế nào để bạn đưa ra và triển khai một chiến lược sao lưu và khôi phục dữ liệu hiệu quả trên AWS?**
3. **Bạn đã có kinh nghiệm với việc triển khai và quản lý Kubernetes trên AWS chưa? Nếu có, nêu các thực tiễn tốt của bạn.**
4. **Làm thế nào để bạn tối ưu hóa hiệu suất của một ứng dụng web trên AWS?**
5. **Bạn đã có kinh nghiệm với việc xây dựng và triển khai các hệ thống CI/CD trên AWS chưa? Nếu có, hãy mô tả quy trình của bạn.**
6. **Bạn đã từng đối mặt với vấn đề về quyền truy cập và bảo mật trên AWS? Làm thế nào để bạn giải quyết vấn đề này?**
7. **Bạn đã phối hợp với các đội khác như phát triển phần mềm, bảo mật, hoặc kinh doanh để triển khai một dự án AWS lớn? Làm thế nào để bạn quản lý mối quan hệ này?**
8. **Bạn đã từng hướng dẫn hoặc đào tạo nhân viên mới về AWS? Làm thế nào để bạn truyền đạt kiến thức và kinh nghiệm của mình?**
9. **Làm thế nào để bạn xử lý các vấn đề liên quan đến hiệu suất và mở rộng cho một ứng dụng đang hoạt động trên AWS?**
10. **Bạn đã từng đảm nhận vai trò chính trong việc thiết kế kiến trúc hệ thống phân tán trên AWS? Nếu có, hãy chia sẻ kế hoạch và quyết định quan trọng bạn đã đưa ra.**
### A
- Tôi đã có cơ hội tham gia vào một dự án AWS phức tạp nhằm triển khai một hệ thống IoT và phân tích dữ liệu cho một hãng hàng không lớn. Dự án yêu cầu tích hợp nhiều dịch vụ AWS như IoT Core, Lambda, DynamoDB, và Redshift để xử lý và phân tích dữ liệu từ hàng trăm máy bay và hàng triệu điểm dữ liệu từ các cảm biến trên máy bay.

- Một trong những thách thức lớn nhất là đảm bảo tính sẵn sàng và độ chính xác cao của dữ liệu thu thập từ các máy bay với môi trường mạng không đồng nhất trên khắp thế giới. Để giải quyết vấn đề này, chúng tôi đã thiết kế một kiến trúc dựa trên AWS Greengrass để xử lý dữ liệu ngoại vi từ các máy bay một cách địa phương, trước khi truyền lên AWS IoT Core. Điều này giúp giảm độ trễ và tăng tính tin cậy của hệ thống trong mọi điều kiện mạng.

- Việc quản lý và phân tích dữ liệu lớn cũng là một thử thách. Chúng tôi đã sử dụng AWS Lambda và DynamoDB để xử lý và lưu trữ dữ liệu với tốc độ và khả năng mở rộng cao. Đồng thời, việc triển khai và tự động hóa hệ thống sử dụng AWS CloudFormation và Terraform đã giúp chúng tôi duy trì tính nhất quán và dễ dàng mở rộng hệ thống khi cần thiết.

- Để đảm bảo tính an toàn và tuân thủ chuẩn bảo mật, chúng tôi đã triển khai các giải pháp bảo mật như IAM roles, AWS KMS để mã hóa dữ liệu và AWS CloudTrail để theo dõi các hoạt động API. Điều này giúp đảm bảo rằng dữ liệu của khách hàng luôn được bảo vệ một cách tối đa.

- Cuối cùng, việc triển khai hệ thống này không chỉ yêu cầu kỹ năng kỹ thuật mà còn yêu cầu khả năng phối hợp chặt chẽ với các bên liên quan như nhà cung cấp phần cứng và phần mềm của máy bay, đảm bảo tính tương thích và hiệu quả cao của dự án.