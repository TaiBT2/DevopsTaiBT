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
## Check các luồng đang chiếm băng thông
```
nethogs
```
## OSI Model
Mô hình OSI (Open Systems Interconnection) là một mô hình tham chiếu được thiết kế để chuẩn hóa các chức năng của hệ thống mạng, nhằm giúp các thiết bị mạng của các hãng khác nhau có thể giao tiếp với nhau. Mô hình này chia các chức năng mạng thành bảy tầng, mỗi tầng có một vai trò cụ thể. Dưới đây là giải thích chi tiết về từng tầng, kèm theo ví dụ minh họa cho mỗi tầng.

### Tầng 1: Physical Layer (Tầng vật lý)

**Chức năng:** Tầng này liên quan đến các phương tiện truyền dẫn vật lý của dữ liệu, như cáp mạng, sóng vô tuyến, và các thiết bị vật lý khác.

**Ví dụ:** Khi bạn kết nối máy tính của mình với router bằng cáp Ethernet, bạn đang làm việc ở tầng vật lý. Các tín hiệu điện truyền qua cáp là dữ liệu ở tầng này.

### Tầng 2: Data Link Layer (Tầng liên kết dữ liệu)

**Chức năng:** Tầng này đảm bảo truyền dữ liệu tin cậy giữa hai thiết bị liền kề trên cùng một mạng vật lý. Nó cũng xử lý địa chỉ vật lý (địa chỉ MAC) và phát hiện lỗi.

**Ví dụ:** Khi một khung dữ liệu (frame) được truyền qua mạng Ethernet, tầng liên kết dữ liệu sử dụng địa chỉ MAC để định danh nguồn và đích của dữ liệu.

### Tầng 3: Network Layer (Tầng mạng)

**Chức năng:** Tầng mạng xử lý việc định tuyến các gói dữ liệu (packets) từ nguồn tới đích thông qua một hoặc nhiều mạng khác nhau, sử dụng địa chỉ IP.

**Ví dụ:** Khi bạn gửi một email, địa chỉ IP của máy tính bạn và máy chủ email sẽ được sử dụng để định tuyến các gói dữ liệu qua internet.

### Tầng 4: Transport Layer (Tầng vận chuyển)

**Chức năng:** Tầng này cung cấp truyền tải dữ liệu tin cậy giữa các ứng dụng, bao gồm việc phân mảnh và tái hợp dữ liệu, kiểm soát luồng, và xử lý lỗi. Các giao thức phổ biến ở tầng này là TCP (Transmission Control Protocol) và UDP (User Datagram Protocol).

**Ví dụ:** Khi bạn tải một trang web, giao thức TCP đảm bảo rằng tất cả các gói dữ liệu của trang web được nhận và sắp xếp đúng thứ tự.

### Tầng 5: Session Layer (Tầng phiên)

**Chức năng:** Tầng phiên quản lý và duy trì các phiên giao tiếp giữa các ứng dụng. Nó thiết lập, quản lý và kết thúc các phiên kết nối giữa hai thiết bị.

**Ví dụ:** Khi bạn thực hiện một cuộc gọi video, tầng phiên đảm bảo rằng phiên giao tiếp giữa máy tính của bạn và máy tính đối tác được duy trì.

### Tầng 6: Presentation Layer (Tầng trình bày)

**Chức năng:** Tầng này chịu trách nhiệm về việc mã hóa, giải mã, nén và giải nén dữ liệu, cũng như chuyển đổi định dạng dữ liệu để các ứng dụng có thể hiểu được.

**Ví dụ:** Khi bạn mở một tập tin PDF, tầng trình bày sẽ giải mã và hiển thị nội dung của tập tin đó đúng định dạng.

### Tầng 7: Application Layer (Tầng ứng dụng)

**Chức năng:** Tầng ứng dụng là tầng gần người dùng nhất, cung cấp các dịch vụ và ứng dụng mạng trực tiếp cho người dùng cuối như email, web, và truyền tệp.

**Ví dụ:** Khi bạn sử dụng trình duyệt web để truy cập một trang web, giao thức HTTP/HTTPS hoạt động ở tầng ứng dụng để truyền dữ liệu giữa trình duyệt của bạn và máy chủ web.

### Ví dụ cụ thể của một phiên giao tiếp qua mạng:

1. **Application Layer (Tầng ứng dụng):** Bạn mở trình duyệt và nhập URL của một trang web.
2. **Presentation Layer (Tầng trình bày):** Trình duyệt chuyển đổi yêu cầu HTTP thành dạng mà tầng dưới có thể xử lý.
3. **Session Layer (Tầng phiên):** Phiên kết nối giữa trình duyệt và máy chủ web được thiết lập.
4. **Transport Layer (Tầng vận chuyển):** Yêu cầu HTTP được phân mảnh thành các gói TCP, mỗi gói có số thứ tự.
5. **Network Layer (Tầng mạng):** Các gói TCP được đóng gói thành các gói IP với địa chỉ IP đích là máy chủ web.
6. **Data Link Layer (Tầng liên kết dữ liệu):** Các gói IP được đóng gói thành các khung Ethernet và truyền qua mạng.
7. **Physical Layer (Tầng vật lý):** Các khung Ethernet được chuyển thành tín hiệu điện và truyền qua cáp mạng đến router.

Khi dữ liệu đến máy chủ web, quá trình này sẽ diễn ra ngược lại từ tầng vật lý lên tầng ứng dụng để máy chủ có thể hiểu và phản hồi lại yêu cầu của bạn.
## Security
Khi người dùng gửi thông tin đến server, có một số cách mà hacker có thể cố gắng lấy thông tin đó. Dưới đây là một số kỹ thuật phổ biến mà hacker có thể sử dụng và các biện pháp để bảo vệ thông tin:

### 1. **Sniffing (Nghe lén mạng)**

- **Mô tả:** Hacker có thể sử dụng các công cụ để nghe lén lưu lượng mạng, đặc biệt là trên các kết nối không được mã hóa (HTTP).
- **Biện pháp:** 
  - **Sử dụng HTTPS:** Mã hóa tất cả các lưu lượng truyền giữa người dùng và server bằng cách sử dụng HTTPS.
  - **HSTS:** Sử dụng HTTP Strict Transport Security (HSTS) để buộc các trình duyệt chỉ kết nối qua HTTPS.

### 2. **Man-in-the-Middle (MitM) Attack (Tấn công người trung gian)**

- **Mô tả:** Hacker chặn và có khả năng thay đổi thông tin được truyền giữa người dùng và server.
- **Biện pháp:**
  - **Sử dụng HTTPS:** Đảm bảo tất cả các kết nối được mã hóa.
  - **Kiểm tra chứng chỉ:** Sử dụng chứng chỉ SSL/TLS hợp lệ và kiểm tra xem người dùng có nhận được chứng chỉ chính xác không.

### 3. **SQL Injection (Tiêm nhiễm SQL)**

- **Mô tả:** Hacker chèn mã SQL độc hại vào các trường nhập liệu, có thể cho phép họ truy cập hoặc thao tác cơ sở dữ liệu.
- **Biện pháp:**
  - **Sử dụng Prepared Statements:** Luôn sử dụng các prepared statements với các tham số liên kết thay vì gắn trực tiếp chuỗi truy vấn SQL.
  - **Sanitize Inputs:** Kiểm tra và làm sạch tất cả dữ liệu nhập vào từ người dùng.

### 4. **Cross-Site Scripting (XSS)**

- **Mô tả:** Hacker chèn mã JavaScript độc hại vào các trang web, khiến nó được thực thi trong trình duyệt của người dùng khác.
- **Biện pháp:**
  - **Escaping Outputs:** Luôn thoát các dữ liệu đầu ra để chúng không được thực thi như mã.
  - **Content Security Policy (CSP):** Sử dụng CSP để hạn chế các nguồn mà trình duyệt có thể tải các script.

### 5. **Cross-Site Request Forgery (CSRF)**

- **Mô tả:** Hacker lừa người dùng thực hiện các hành động không mong muốn trên ứng dụng mà họ đã đăng nhập.
- **Biện pháp:**
  - **CSRF Tokens:** Sử dụng các token CSRF để xác minh rằng các yêu cầu đến từ người dùng hợp lệ.
  - **SameSite Cookie Attribute:** Sử dụng thuộc tính SameSite cho cookie để ngăn chặn các yêu cầu chéo trang không mong muốn.

### 6. **Social Engineering (Kỹ thuật xã hội)**

- **Mô tả:** Hacker lừa người dùng tiết lộ thông tin nhạy cảm.
- **Biện pháp:**
  - **Giáo dục Người dùng:** Đào tạo người dùng nhận biết các kỹ thuật lừa đảo và không tiết lộ thông tin nhạy cảm.
  - **Xác Thực Hai Yếu Tố (2FA):** Sử dụng 2FA để bảo vệ tài khoản người dùng ngay cả khi mật khẩu bị lộ.

### Tóm tắt

Để bảo vệ thông tin người dùng khi gửi đến server, bạn cần:
- Sử dụng HTTPS để mã hóa lưu lượng.
- Kiểm tra và xác thực chứng chỉ SSL/TLS.
- Sử dụng các biện pháp bảo vệ như prepared statements, escaping outputs, CSRF tokens, và các quy tắc CSP.
- Đào tạo người dùng và sử dụng 2FA để tăng cường bảo mật.

Bằng cách áp dụng các biện pháp này, bạn có thể giảm thiểu nguy cơ bị hacker lấy cắp thông tin người dùng.