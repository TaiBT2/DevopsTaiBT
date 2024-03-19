## STANDARD BACKEND
- Iam role : có quyền ghi vào dynamo table và fecth/store bên trong S3
- dynamodb:  dùng để lock key của 1 process vào bên trong nó, vì dynamo có tốc độ đọc ghi nhanh milisecond
- dùng để lưu trữ state khi terraform chạy xong, kms mã hóa dữ liệu state
