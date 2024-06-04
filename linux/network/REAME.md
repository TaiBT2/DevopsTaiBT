## Check network
Khi gặp tình trạng máy chủ truy cập chậm, có nhiều cách để kiểm tra và chẩn đoán các vấn đề liên quan đến mạng. Dưới đây là một số phương pháp và công cụ mà bạn có thể sử dụng để kiểm tra mạng trên hệ thống Linux:

### 1. **Kiểm tra kết nối cơ bản**

- **Ping**: Kiểm tra kết nối giữa máy chủ và một máy chủ khác.
  ```sh
  ping google.com
  ```

- **Traceroute**: Kiểm tra các bước nhảy (hops) từ máy chủ của bạn đến máy chủ đích.
  ```sh
  traceroute google.com
  ```

### 2. **Kiểm tra băng thông và tốc độ mạng**

- **speedtest-cli**: Kiểm tra tốc độ internet (download/upload).
  ```sh
  speedtest-cli
  ```

- **iperf3**: Kiểm tra băng thông giữa hai máy chủ (yêu cầu một máy chạy ở chế độ server và một máy chạy ở chế độ client).
  ```sh
  # Trên máy chủ
  iperf3 -s

  # Trên máy khách
  iperf3 -c SERVER_IP
  ```

### 3. **Giám sát lưu lượng mạng**

- **nload**: Giám sát lưu lượng mạng theo thời gian thực.
  ```sh
  sudo nload
  ```

- **iftop**: Hiển thị các kết nối mạng hiện tại và lượng băng thông đang sử dụng.
  ```sh
  sudo iftop
  ```

- **vnstat**: Giám sát băng thông mạng lâu dài.
  ```sh
  sudo vnstat
  vnstat
  ```

### 4. **Kiểm tra trạng thái giao diện mạng**

- **ethtool**: Kiểm tra và hiển thị thông tin chi tiết về giao diện mạng.
  ```sh
  sudo ethtool eth0
  ```

- **ifconfig** hoặc **ip**: Hiển thị thông tin chi tiết về cấu hình giao diện mạng.
  ```sh
  ifconfig
  # hoặc
  ip a
  ```

### 5. **Kiểm tra bảng định tuyến**

- **route** hoặc **ip route**: Hiển thị bảng định tuyến để kiểm tra đường đi của các gói tin mạng.
  ```sh
  route -n
  # hoặc
  ip route
  ```

### 6. **Kiểm tra DNS**

- **nslookup** hoặc **dig**: Kiểm tra việc phân giải tên miền.
  ```sh
  nslookup google.com
  # hoặc
  dig google.com
  ```

### 7. **Kiểm tra firewall**

- **ufw** hoặc **iptables**: Kiểm tra các quy tắc firewall có thể ảnh hưởng đến kết nối mạng.
  ```sh
  sudo ufw status
  # hoặc
  sudo iptables -L -v -n
  ```

### 8. **Kiểm tra các dịch vụ mạng**

- **netstat** hoặc **ss**: Kiểm tra các cổng mở và các kết nối mạng hiện tại.
  ```sh
  netstat -tuln
  # hoặc
  ss -tuln
  ```

### 9. **Giám sát hệ thống toàn diện**

- **htop** hoặc **top**: Kiểm tra tải hệ thống và xác định xem có quá tải CPU hoặc RAM không.
  ```sh
  htop
  # hoặc
  top
  ```

### Kết hợp các phương pháp trên sẽ giúp bạn chẩn đoán các vấn đề liên quan đến mạng một cách toàn diện và hiệu quả. Bằng cách kiểm tra từng phần của hệ thống, bạn có thể xác định nguyên nhân gốc rễ của việc truy cập chậm và thực hiện các biện pháp khắc phục phù hợp.