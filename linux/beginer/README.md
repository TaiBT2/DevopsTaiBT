Linux cung cấp nhiều lệnh cơ bản để thực hiện các tác vụ quản lý hệ thống, xử lý tệp và điều hướng. Dưới đây là một số lệnh cơ bản thường được sử dụng trong môi trường Linux:

### 1. Điều hướng hệ thống tệp

#### `ls`

Hiển thị danh sách các tệp và thư mục trong thư mục hiện tại.

```sh
ls
ls -l   # Hiển thị chi tiết
ls -a   # Hiển thị cả các tệp ẩn
```

#### `cd`

Thay đổi thư mục làm việc hiện tại.

```sh
cd /path/to/directory  # Chuyển đến thư mục được chỉ định
cd ..                  # Quay lại thư mục cha
cd ~                   # Chuyển đến thư mục chính của người dùng
```

#### `pwd`

Hiển thị đường dẫn của thư mục làm việc hiện tại.

```sh
pwd
```

### 2. Quản lý tệp và thư mục

#### `cp`

Sao chép tệp hoặc thư mục.

```sh
cp source_file destination_file        # Sao chép tệp
cp -r source_directory destination_directory  # Sao chép thư mục
```

#### `mv`

Di chuyển hoặc đổi tên tệp hoặc thư mục.

```sh
mv source_file destination_file        # Di chuyển tệp
mv old_directory new_directory         # Đổi tên thư mục
```

#### `rm`

Xóa tệp hoặc thư mục.

```sh
rm file_name                    # Xóa tệp
rm -r directory_name            # Xóa thư mục và các tệp con
rm -rf directory_name           # Xóa thư mục và các tệp con mà không cần hỏi
```

#### `mkdir`

Tạo thư mục mới.

```sh
mkdir new_directory
```

#### `touch`

Tạo tệp mới hoặc cập nhật dấu thời gian của tệp hiện có.

```sh
touch new_file
```

### 3. Xem và chỉnh sửa tệp

#### `cat`

Hiển thị nội dung của tệp.

```sh
cat file_name
```

#### `less`

Xem nội dung của tệp từng trang một.

```sh
less file_name
```

#### `head` và `tail`

Hiển thị phần đầu hoặc phần cuối của tệp.

```sh
head file_name            # Hiển thị 10 dòng đầu tiên
head -n 20 file_name      # Hiển thị 20 dòng đầu tiên
tail file_name            # Hiển thị 10 dòng cuối cùng
tail -n 20 file_name      # Hiển thị 20 dòng cuối cùng
```

#### `nano` và `vim`

Chỉnh sửa tệp trong trình soạn thảo văn bản.

```sh
nano file_name   # Mở tệp với nano
vim file_name    # Mở tệp với vim
```

### 4. Quản lý hệ thống

#### `sudo`

Chạy một lệnh với quyền quản trị.

```sh
sudo command    # Chạy lệnh với quyền root
```

#### `ps`

Hiển thị thông tin về các tiến trình đang chạy.

```sh
ps aux          # Hiển thị tất cả các tiến trình
```

#### `kill`

Kết thúc một tiến trình.

```sh
kill process_id          # Kết thúc tiến trình dựa trên ID
kill -9 process_id       # Buộc kết thúc tiến trình
```

#### `top`

Hiển thị các tiến trình đang chạy theo thời gian thực.

```sh
top
```

#### `df`

Hiển thị thông tin về không gian đĩa sử dụng.

```sh
df -h          # Hiển thị thông tin với định dạng dễ đọc
```

#### `du`

Hiển thị không gian đĩa sử dụng bởi các tệp và thư mục.

```sh
du -sh *       # Hiển thị kích thước của tất cả các mục trong thư mục hiện tại
```

### 5. Mạng và Internet

#### `ping`

Kiểm tra kết nối mạng đến một máy chủ.

```sh
ping example.com
```

#### `curl`

Truy xuất nội dung từ một URL.

```sh
curl http://example.com
```

#### `wget`

Tải xuống tệp từ một URL.

```sh
wget http://example.com/file.zip
```

#### `ifconfig`

Hiển thị cấu hình mạng của hệ thống.

```sh
ifconfig
```

### 6. Quản lý gói

#### `apt`

Quản lý các gói trên các hệ thống Debian/Ubuntu.

```sh
sudo apt update            # Cập nhật danh sách gói
sudo apt upgrade           # Nâng cấp các gói đã cài đặt
sudo apt install package_name  # Cài đặt gói mới
sudo apt remove package_name   # Gỡ cài đặt gói
```

#### `yum`

Quản lý các gói trên các hệ thống Red Hat/CentOS.

```sh
sudo yum update            # Cập nhật hệ thống
sudo yum install package_name  # Cài đặt gói mới
sudo yum remove package_name   # Gỡ cài đặt gói
```

### 7. Các lệnh tiện ích khác

#### `grep`

Tìm kiếm nội dung trong các tệp.

```sh
grep "search_string" file_name
grep -r "search_string" directory_name  # Tìm kiếm trong thư mục và các tệp con
```

#### `find`

Tìm kiếm tệp và thư mục.

```sh
find /path/to/search -name "file_name"
```

#### `chmod`

Thay đổi quyền truy cập của tệp hoặc thư mục.

```sh
chmod 755 file_name        # Đặt quyền đọc, ghi, thực thi cho chủ sở hữu và chỉ đọc cho nhóm và người khác
```

#### `chown`

Thay đổi chủ sở hữu và nhóm của tệp hoặc thư mục.

```sh
sudo chown user:group file_name
```

Những lệnh trên là cơ bản và thường được sử dụng trong hệ thống Linux. Nắm vững các lệnh này sẽ giúp bạn làm việc hiệu quả hơn trong môi trường dòng lệnh Linux. Nếu bạn có câu hỏi cụ thể về bất kỳ lệnh nào hoặc cần trợ giúp thêm, hãy cho tôi biết!