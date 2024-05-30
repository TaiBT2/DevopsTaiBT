Các lệnh nâng cao trong Linux cho phép bạn thực hiện các tác vụ phức tạp hơn, quản lý hệ thống hiệu quả hơn và làm việc với dữ liệu một cách mạnh mẽ. Dưới đây là một số lệnh nâng cao thường được sử dụng:

### 1. Quản lý hệ thống và tài nguyên

#### `htop`

`htop` là một công cụ tương tác mạnh mẽ để theo dõi các tiến trình và sử dụng tài nguyên.

```sh
htop
```

#### `systemctl`

Quản lý các dịch vụ hệ thống trong các hệ thống dựa trên systemd.

```sh
sudo systemctl start service_name      # Khởi động dịch vụ
sudo systemctl stop service_name       # Dừng dịch vụ
sudo systemctl restart service_name    # Khởi động lại dịch vụ
sudo systemctl status service_name     # Kiểm tra trạng thái của dịch vụ
sudo systemctl enable service_name     # Kích hoạt dịch vụ khởi động cùng hệ thống
sudo systemctl disable service_name    # Vô hiệu hóa dịch vụ khởi động cùng hệ thống
```

#### `journalctl`

Xem nhật ký hệ thống và dịch vụ.

```sh
journalctl -u service_name             # Xem nhật ký của một dịch vụ cụ thể
journalctl -f                          # Theo dõi nhật ký hệ thống theo thời gian thực
```

### 2. Quản lý tệp và dữ liệu

#### `rsync`

Đồng bộ hóa tệp và thư mục một cách hiệu quả.

```sh
rsync -avh source_directory/ destination_directory/
```

#### `tar`

Tạo và giải nén các tệp lưu trữ.

```sh
tar -czvf archive_name.tar.gz /path/to/directory  # Tạo tệp tar.gz
tar -xzvf archive_name.tar.gz                     # Giải nén tệp tar.gz
```

#### `awk`

Một ngôn ngữ lập trình nhỏ dùng để xử lý và phân tích dữ liệu.

```sh
awk '{print $1}' file_name                          # In cột đầu tiên của mỗi dòng
awk '/pattern/ {print $0}' file_name                # In các dòng chứa "pattern"
awk '{sum += $1} END {print sum}' file_name         # Tính tổng của cột đầu tiên
```

#### `sed`

Trình soạn thảo luồng dùng để tìm kiếm và thay thế trong tệp.

```sh
sed 's/old_string/new_string/g' file_name            # Thay thế "old_string" bằng "new_string"
sed -n 'p;10q' file_name                             # In ra 10 dòng đầu tiên
```

### 3. Quản lý mạng

#### `iptables`

Quản lý tường lửa và bộ lọc gói.

```sh
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT    # Cho phép kết nối SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT    # Cho phép kết nối HTTP
sudo iptables -L                                      # Liệt kê các quy tắc hiện tại
```

#### `tcpdump`

Phân tích lưu lượng mạng.

```sh
sudo tcpdump -i eth0                               # Theo dõi lưu lượng trên giao diện eth0
sudo tcpdump -i eth0 'port 80'                     # Theo dõi lưu lượng HTTP
```

#### `nmap`

Quét mạng và kiểm tra bảo mật.

```sh
nmap -sP 192.168.1.0/24                            # Quét các thiết bị trong mạng
nmap -sV 192.168.1.1                               # Kiểm tra các dịch vụ đang chạy trên thiết bị
```

### 4. Tạo tập lệnh và lập trình

#### `bash scripting`

Viết các tập lệnh Bash để tự động hóa các tác vụ.

```sh
#!/bin/bash

# Tập lệnh đơn giản để sao lưu tệp
SOURCE="/path/to/source"
DESTINATION="/path/to/destination"
DATE=$(date +%Y%m%d)

tar -czvf ${DESTINATION}/backup_${DATE}.tar.gz ${SOURCE}
echo "Backup completed for ${DATE}"
```

#### `cron`

Lên lịch các tác vụ tự động với `cron`.

```sh
crontab -e                # Chỉnh sửa tập tin crontab để thêm lịch biểu

# Ví dụ: Chạy tập lệnh sao lưu mỗi ngày vào lúc 2 giờ sáng
0 2 * * * /path/to/backup_script.sh
```

### 5. Quản lý người dùng và quyền

#### `usermod`

Chỉnh sửa thông tin người dùng.

```sh
sudo usermod -aG group_name user_name            # Thêm người dùng vào nhóm
sudo usermod -d /new/home/directory user_name    # Thay đổi thư mục chính của người dùng
```

#### `chown`

Thay đổi quyền sở hữu tệp và thư mục.

```sh
sudo chown user:group file_name                  # Thay đổi chủ sở hữu của tệp
sudo chown -R user:group directory_name          # Thay đổi chủ sở hữu của thư mục và các tệp con
```

#### `chmod`

Thay đổi quyền truy cập tệp và thư mục.

```sh
chmod 755 file_name                              # Đặt quyền đọc, ghi, thực thi cho chủ sở hữu và chỉ đọc cho nhóm và người khác
chmod -R 755 directory_name                      # Đặt quyền cho thư mục và các tệp con
```

### 6. Các công cụ và lệnh khác

#### `grep`

Tìm kiếm văn bản trong tệp.

```sh
grep "search_string" file_name                   # Tìm kiếm chuỗi trong tệp
grep -r "search_string" directory_name           # Tìm kiếm trong thư mục và các tệp con
```

#### `find`

Tìm kiếm tệp và thư mục dựa trên các tiêu chí khác nhau.

```sh
find /path/to/search -name "file_name"           # Tìm kiếm theo tên
find /path/to/search -type f -size +10M          # Tìm kiếm các tệp lớn hơn 10MB
```

#### `locate`

Tìm tệp và thư mục một cách nhanh chóng bằng cơ sở dữ liệu được lập chỉ mục.

```sh
locate file_name
```

#### `ssh`

Kết nối đến máy chủ từ xa qua SSH.

```sh
ssh user@remote_host
```

#### `scp`

Sao chép tệp giữa các máy tính qua SSH.

```sh
scp source_file user@remote_host:/path/to/destination
scp user@remote_host:/path/to/source_file destination
```

Những lệnh nâng cao này giúp bạn thực hiện các tác vụ quản lý hệ thống phức tạp và hiệu quả hơn trong môi trường Linux. Nắm vững các lệnh này sẽ giúp bạn trở thành một quản trị viên hệ thống giỏi hơn. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần trợ giúp thêm, hãy cho tôi biết!