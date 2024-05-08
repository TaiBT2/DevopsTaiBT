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
- cải thiện ộ sẳn sàng, bảo mật, hiệu năng của ứng dụng ra internet. giúp xem là khi user call api sẽ gọi đến server nào. dựa vào độ trể. server nào có độ trể thấp hơn sẽ call đến đó
- khi tạo 1 GA thì sẽ giúp chúng ta điều hướng traffic đến nhiều server trên nhiều region, 
- GA sẽ cung cấp 1 DNS và thêm các static IP theo số region