## COMMON COMMAND
- check size folder
```
find /mnt/HDD/nfs -type f -size +1M -exec du -h {} + | sort -rh | head -n 10
```
- rsync
```
rsync -aP /mnt/HDD/nfs/s24dapvpwebpt-test-data-postgresql-0-pvc-c00f4d3e-bea1-4d6d-89f4-e04a0fe5ed1a/ root@10.0.0.79:/mnt/HDD/nfs/k8s-pv/pvc-337e408e-ea8d-4225-87a8-ba6e8ee8ec1a/
```
- run suppervisord 
```
"/usr/bin/supervisord", "-c", "/etc/supervisord.conf"
```
- check size folder , file
```
du -sh /path_folder
du -sh /file_name
```
```
sudo sync; echo 1 > /proc/sys/vm/drop_caches
du -hsc /var/docker/overlay2
find -type f -exec du -sh {} + | sort -rh | head -n 5
netstat -a -o | grep mysql
---

---
prompt:
 - clear :cls
 - ls: dir
 - ipconfig /flushdns
---
kubectl create secret docker-registry fms-repo-key --docker-server=nexusrepo.rikkei.org --docker-username=admin --docker-password=secret --docker-email=thanhtai18021994@gmail.com -n fms
---

db.createUser({
    user: "rkdg1-user",
    pwd: "12345678",
    roles: [
      "readWrite"
    ],
    passwordDigestor: "server"
  })

--
db.adminCommand(
   {
      shutdown: 1,
      comment: "Convert to cluster"
   }
)
---
mongod --auth --port <port> --dbpath /var/lib/mongodb --replSet 
mongod --auth --port 27017 --dbpath "/home/taibt/data" --replSet "rs0"
--
cfg = rs.conf()
cfg.members[0].host = "mongo2.example.net"
rs.reconfig(cfg)
--
sudo iptables -I INPUT -i eth0 -p tcp --dport 3306 -m comment --comment "# Anaconda Repo #" -j ACCEPT
```
## Centos
### Install certbot
- install python 3.8
```
yum install python3.8
sudo alternatives --set python3 /usr/bin/python3.8
```
- Install snapd
```
sudo yum install epel-release
sudo yum install snapd
```
- create symlink for snap
```
sudo ln -s /var/lib/snapd/snap /snap
```
- Start and Enable snapd:
```
sudo systemctl enable --now snapd.socket
sudo systemctl start snapd.seeded.service

```
- Wait for snapd to Initialize:
```
sudo systemctl status snapd.seeded.service
```
- install certbot
```
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
```
- symlink to acess
```
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```
- run certbot
```
sudo certbot --nginx
```
## AWK
Sử dụng `awk` để in các dòng khớp với một mẫu (pattern) là một trong những ứng dụng cơ bản và mạnh mẽ của công cụ này. Dưới đây là hướng dẫn chi tiết và các ví dụ về cách thực hiện điều này.

### Cú pháp cơ bản

Cú pháp cơ bản để in các dòng khớp với một mẫu bằng `awk` là:

```sh
awk '/pattern/ {print}' file
```

- `/pattern/`: Đây là mẫu (pattern) bạn muốn khớp. Nó có thể là một chuỗi văn bản hoặc một biểu thức chính quy (regex).
- `{print}`: Hành động sẽ được thực hiện khi mẫu khớp. Ở đây, `print` được sử dụng để in các dòng khớp.

### Ví dụ cụ thể

1. **In các dòng chứa từ "error" trong tệp `logfile.txt`**:

    ```sh
    awk '/error/ {print}' logfile.txt
    ```

2. **In các dòng chứa một số cụ thể, ví dụ 404, trong tệp `access.log`**:

    ```sh
    awk '/404/ {print}' access.log
    ```

3. **In các dòng bắt đầu bằng "INFO" trong tệp `system.log`**:

    ```sh
    awk '/^INFO/ {print}' system.log
    ```

### Các ví dụ phức tạp hơn

1. **In các dòng chứa từ "error" nhưng không phân biệt chữ hoa chữ thường**:
   
    ```sh
    awk 'tolower($0) ~ /error/ {print}' logfile.txt
    ```

    - `tolower($0)`: Chuyển toàn bộ dòng (`$0`) thành chữ thường.
    - `~`: Toán tử khớp với biểu thức chính quy (regex).

2. **In các dòng chứa từ "error" và in kèm theo số dòng**:
   
    ```sh
    awk '/error/ {print NR, $0}' logfile.txt
    ```

    - `NR`: Biến tích hợp của `awk` đại diện cho số dòng hiện tại.

3. **In các dòng chứa từ "error" và chỉ in cột thứ nhất và thứ ba**:
   
    ```sh
    awk '/error/ {print $1, $3}' logfile.txt
    ```

    - `$1`: Đại diện cho cột đầu tiên.
    - `$3`: Đại diện cho cột thứ ba.

4. **In các dòng không chứa từ "error"**:
   
    ```sh
    awk '!/error/ {print}' logfile.txt
    ```

    - `!`: Toán tử phủ định, có nghĩa là khớp với các dòng không chứa mẫu.

### Ví dụ đầy đủ

Giả sử bạn có một tệp `students.txt` với nội dung sau:

```txt
John 90
Jane 85
Doe 78
Smith 92
Alice 60
Bob 75
```

1. **In các dòng mà tên sinh viên bắt đầu bằng chữ "J"**:

    ```sh
    awk '/^J/ {print}' students.txt
    ```

2. **In các dòng mà điểm số lớn hơn hoặc bằng 80**:

    ```sh
    awk '$2 >= 80 {print}' students.txt
    ```

3. **In các dòng mà điểm số nhỏ hơn 80 và in kèm theo số dòng**:

    ```sh
    awk '$2 < 80 {print NR, $0}' students.txt
    ```

### Tổng kết

`awk` là một công cụ mạnh mẽ để xử lý văn bản dựa trên mẫu. Với cú pháp đơn giản, bạn có thể nhanh chóng lọc và in các dòng khớp với các tiêu chí cụ thể từ một tệp văn bản. Bằng cách kết hợp các mẫu và hành động trong `awk`, bạn có thể thực hiện các thao tác phức tạp và linh hoạt trên dữ liệu văn bản.
## SED COMMAND
`sed` là một công cụ mạnh mẽ trong Linux dùng để xử lý và biến đổi văn bản. Dưới đây là một số ví dụ cơ bản và nâng cao về cách sử dụng `sed` để thực hiện các tác vụ khác nhau.

### 1. Cú pháp cơ bản

Cú pháp cơ bản của `sed`:
```sh
sed 's/pattern/replacement/' file
```
- `s`: Chỉ thị `sed` thực hiện thao tác thay thế.
- `pattern`: Mẫu văn bản cần tìm.
- `replacement`: Văn bản thay thế.
- `file`: Tệp văn bản cần xử lý.

### 2. Ví dụ cơ bản

1. **Thay thế từ đầu tiên xuất hiện của "hello" bằng "hi" trong mỗi dòng của tệp `file.txt`:**
   ```sh
   sed 's/hello/hi/' file.txt
   ```

2. **Thay thế tất cả các từ "hello" bằng "hi" trong mỗi dòng của tệp `file.txt`:**
   ```sh
   sed 's/hello/hi/g' file.txt
   ```
   - `g`: Thực hiện thay thế toàn bộ các từ "hello" trên mỗi dòng.

3. **Thay thế từ "hello" bằng "hi" trên dòng cụ thể, ví dụ dòng thứ 3:**
   ```sh
   sed '3s/hello/hi/' file.txt
   ```

### 3. Thao tác trên tệp mà không thay đổi tệp gốc

1. **In kết quả ra màn hình mà không thay đổi tệp gốc:**
   ```sh
   sed 's/hello/hi/' file.txt
   ```

2. **Lưu kết quả vào tệp mới:**
   ```sh
   sed 's/hello/hi/' file.txt > newfile.txt
   ```

3. **Chỉnh sửa tệp gốc và lưu thay đổi:**
   ```sh
   sed -i 's/hello/hi/g' file.txt
   ```
   - `-i`: Chỉ thị `sed` chỉnh sửa trực tiếp tệp gốc.

### 4. Thao tác nâng cao

1. **Xóa các dòng chứa một mẫu cụ thể, ví dụ dòng chứa "delete":**
   ```sh
   sed '/delete/d' file.txt
   ```
   - `d`: Lệnh xóa dòng.

2. **Thay thế từ "hello" bằng "hi" chỉ trên các dòng khớp với mẫu "pattern":**
   ```sh
   sed '/pattern/s/hello/hi/g' file.txt
   ```

3. **Chèn văn bản vào trước hoặc sau một dòng cụ thể:**
   - Chèn "new text" sau dòng chứa "pattern":
     ```sh
     sed '/pattern/a new text' file.txt
     ```
     - `a`: Chỉ thị `sed` chèn văn bản sau dòng khớp mẫu.

   - Chèn "new text" trước dòng chứa "pattern":
     ```sh
     sed '/pattern/i new text' file.txt
     ```
     - `i`: Chỉ thị `sed` chèn văn bản trước dòng khớp mẫu.

4. **Thay đổi nhiều mẫu khác nhau:**
   ```sh
   sed -e 's/hello/hi/g' -e 's/world/earth/g' file.txt
   ```
   - `-e`: Cho phép sử dụng nhiều biểu thức `sed`.

### 5. Ví dụ đầy đủ

Giả sử bạn có một tệp `students.txt` với nội dung:
```txt
John 90
Jane 85
Doe 78
Smith 92
Alice 60
Bob 75
```

1. **Tăng điểm số của tất cả sinh viên lên 5 đơn vị:**
   ```sh
   sed 's/\([0-9][0-9]*\)/\1+5/' students.txt | bc
   ```
   - `\([0-9][0-9]*\)`: Bắt nhóm các số.
   - `\1+5`: Thay thế nhóm bắt được bằng chính nó cộng thêm 5.
   - `| bc`: Sử dụng `bc` để tính toán.

2. **Xóa các dòng có điểm số dưới 80:**
   ```sh
   sed '/ [0-7][0-9]$/d' students.txt
   ```
   - `/ [0-7][0-9]$/d`: Mẫu để khớp với các dòng kết thúc bằng số từ 00 đến 79 và xóa các dòng đó.

3. **Thêm một tiêu đề "Name Score" vào đầu tệp:**
   ```sh
   sed '1i Name Score' students.txt
   ```
   - `1i`: Chèn văn bản ở dòng đầu tiên.

4. **Đổi tên "John" thành "Jonathan":**
   ```sh
   sed 's/John/Jonathan/' students.txt
   ```

5. **Thay đổi định dạng văn bản:**
   - Chuyển đổi từ "John 90" thành "Student: John, Score: 90":
     ```sh
     sed 's/\([^ ]*\) \([^ ]*\)/Student: \1, Score: \2/' students.txt
     ```
   - `\([^ ]*\)`: Bắt nhóm các ký tự không phải là khoảng trắng (tên).
   - `\([^ ]*\)`: Bắt nhóm các ký tự không phải là khoảng trắng (điểm số).
   - `Student: \1, Score: \2`: Thay thế bằng định dạng mới.

### Tổng kết

`sed` là một công cụ mạnh mẽ và linh hoạt để xử lý văn bản trong dòng lệnh Linux. Với `sed`, bạn có thể thực hiện các thao tác từ đơn giản đến phức tạp trên các tệp văn bản. Nếu bạn cần xử lý các tác vụ cụ thể hoặc cần thêm trợ giúp, hãy cho tôi biết!
## Find Command
Lệnh `find` trong Linux được sử dụng để tìm kiếm tệp và thư mục trong hệ thống tệp dựa trên các tiêu chí cụ thể. Đây là một công cụ rất mạnh mẽ và linh hoạt. Dưới đây là một số ví dụ cụ thể về cách sử dụng lệnh `find`.

### 1. Cú pháp cơ bản

Cú pháp cơ bản của lệnh `find`:
```sh
find [path] [options] [expression]
```
- `[path]`: Đường dẫn bắt đầu tìm kiếm (thư mục gốc).
- `[options]`: Các tùy chọn bổ sung (ví dụ: `-name`, `-type`).
- `[expression]`: Biểu thức để khớp với tệp hoặc thư mục.

### 2. Ví dụ cơ bản

1. **Tìm tất cả các tệp trong thư mục hiện tại và các thư mục con:**
   ```sh
   find .
   ```

2. **Tìm tệp có tên cụ thể, ví dụ `example.txt`, trong thư mục hiện tại và các thư mục con:**
   ```sh
   find . -name "example.txt"
   ```

3. **Tìm tệp có tên cụ thể không phân biệt chữ hoa chữ thường:**
   ```sh
   find . -iname "example.txt"
   ```

4. **Tìm tất cả các thư mục trong thư mục hiện tại và các thư mục con:**
   ```sh
   find . -type d
   ```
   - `-type d`: Chỉ tìm kiếm thư mục.

5. **Tìm tất cả các tệp có phần mở rộng `.txt` trong thư mục hiện tại và các thư mục con:**
   ```sh
   find . -name "*.txt"
   ```

### 3. Các ví dụ nâng cao

1. **Tìm tệp lớn hơn 100MB:**
   ```sh
   find . -type f -size +100M
   ```
   - `-type f`: Chỉ tìm kiếm tệp.
   - `-size +100M`: Tìm tệp có kích thước lớn hơn 100 megabytes.

2. **Tìm tệp được sửa đổi trong vòng 7 ngày qua:**
   ```sh
   find . -type f -mtime -7
   ```
   - `-mtime -7`: Tìm tệp được sửa đổi trong vòng 7 ngày qua.

3. **Tìm tệp được truy cập trong vòng 7 ngày qua:**
   ```sh
   find . -type f -atime -7
   ```
   - `-atime -7`: Tìm tệp được truy cập trong vòng 7 ngày qua.

4. **Tìm tệp được sửa đổi hơn 30 ngày trước:**
   ```sh
   find . -type f -mtime +30
   ```
   - `-mtime +30`: Tìm tệp được sửa đổi hơn 30 ngày trước.

5. **Tìm tệp thuộc về một người dùng cụ thể:**
   ```sh
   find . -type f -user username
   ```
   - `-user username`: Tìm tệp thuộc về người dùng `username`.

6. **Tìm tệp có quyền cụ thể, ví dụ 644:**
   ```sh
   find . -type f -perm 644
   ```
   - `-perm 644`: Tìm tệp có quyền 644.

### 4. Thực hiện hành động trên tệp tìm thấy

1. **Xóa tệp có phần mở rộng `.tmp`:**
   ```sh
   find . -type f -name "*.tmp" -exec rm {} +
   ```
   - `-exec rm {} +`: Xóa các tệp được tìm thấy. `{}` đại diện cho tệp được tìm thấy, và `+` kết thúc lệnh `-exec`.

2. **In thông tin chi tiết về tệp:**
   ```sh
   find . -type f -name "*.txt" -exec ls -l {} +
   ```

3. **Thay đổi quyền của các tệp:**
   ```sh
   find . -type f -name "*.sh" -exec chmod 755 {} +
   ```

### 5. Ví dụ đầy đủ

Giả sử bạn muốn tìm tất cả các tệp `.log` trong thư mục `/var/logs` được sửa đổi trong vòng 7 ngày qua và xóa chúng:

```sh
find /var/logs -type f -name "*.log" -mtime -7 -exec rm {} +
```

- `/var/logs`: Thư mục bắt đầu tìm kiếm.
- `-type f`: Chỉ tìm kiếm tệp.
- `-name "*.log"`: Tìm tệp có phần mở rộng `.log`.
- `-mtime -7`: Tìm tệp được sửa đổi trong vòng 7 ngày qua.
- `-exec rm {} +`: Xóa các tệp tìm thấy.

### 6. Tìm kiếm theo nội dung tệp

Để tìm các tệp có chứa một mẫu cụ thể trong nội dung, bạn có thể kết hợp `find` với `grep`:

1. **Tìm tất cả các tệp `.txt` chứa từ "error":**
   ```sh
   find . -type f -name "*.txt" -exec grep -l "error" {} +
   ```

   - `grep -l "error"`: Tìm tệp chứa từ "error" và chỉ in tên tệp.

### Tổng kết

Lệnh `find` là một công cụ rất mạnh mẽ và linh hoạt để tìm kiếm tệp và thư mục trong hệ thống tệp Linux. Bạn có thể sử dụng các tùy chọn và biểu thức khác nhau để tùy chỉnh tìm kiếm của mình. Nếu bạn cần tìm kiếm cụ thể hoặc thực hiện hành động trên các tệp tìm thấy, `find` có thể là công cụ rất hữu ích. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần giúp đỡ thêm, hãy cho tôi biết!
