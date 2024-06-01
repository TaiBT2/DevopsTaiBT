## Mất bao lâu để tải 10TB từ on-prem lên DC cloud
Để tính toán thời gian cần thiết để tải dữ liệu từ một hệ thống on-premise lên trung tâm dữ liệu đám mây AWS, bạn cần biết tốc độ đường truyền mạng của bạn. Công thức cơ bản để tính thời gian tải lên là:

\[ \text{Thời gian tải lên} = \frac{\text{Dung lượng dữ liệu}}{\text{Tốc độ truyền tải}} \]

### Các yếu tố cần xem xét:
1. **Dung lượng dữ liệu (Data Size)**: Tổng dung lượng dữ liệu bạn cần tải lên, trong trường hợp này là 10TB.
2. **Tốc độ truyền tải (Upload Speed)**: Tốc độ kết nối mạng của bạn từ hệ thống on-premise đến AWS, thường được đo bằng Mbps (megabits per second) hoặc Gbps (gigabits per second).

### Các bước tính toán:
1. **Chuyển đổi đơn vị**:
   - 1 TB (terabyte) = 1024 GB (gigabyte)
   - 1 GB (gigabyte) = 1024 MB (megabyte)
   - 1 MB (megabyte) = 8 Mb (megabit)

   Vì vậy, 10 TB = \( 10 \times 1024 \times 1024 \times 8 \) Mb = 83,886,080 Mb.

2. **Công thức tính thời gian tải lên**:
   - Giả sử tốc độ truyền tải của bạn là \(X\) Mbps.
   - Thời gian tải lên (giờ) = \(\frac{83,886,080 \text{ Mb}}{X \text{ Mbps}}\).

3. **Đổi sang giờ**:
   - Kết quả trên sẽ là thời gian tính bằng giây. Để đổi sang giờ, chia cho 3600 (số giây trong một giờ).

### Ví dụ cụ thể:
Giả sử tốc độ truyền tải của bạn là 100 Mbps:

1. **Chuyển đổi đơn vị**:
   - Dung lượng dữ liệu: 10 TB = 83,886,080 Mb.

2. **Tính thời gian tải lên**:
   - Thời gian tải lên = \(\frac{83,886,080 \text{ Mb}}{100 \text{ Mbps}}\) = 838,860.8 giây.

3. **Đổi sang giờ**:
   - Thời gian tải lên (giờ) = \(\frac{838,860.8 \text{ giây}}{3600 \text{ giây/giờ}}\) ≈ 233 giờ.

### Tổng kết:
Với tốc độ tải lên 100 Mbps, thời gian cần thiết để tải 10 TB dữ liệu lên AWS sẽ là khoảng 233 giờ, tức là gần 10 ngày.

### Các yếu tố khác cần xem xét:
- **Mạng có thể không ổn định**: Tốc độ mạng có thể dao động, do đó bạn nên tính thêm một khoảng thời gian dự phòng.
- **Quá trình nén dữ liệu**: Nếu bạn nén dữ liệu trước khi tải lên, thời gian tải lên có thể giảm.
- **AWS Direct Connect**: Nếu bạn sử dụng AWS Direct Connect, bạn có thể có được tốc độ truyền tải nhanh hơn và ổn định hơn so với kết nối internet công cộng.

Hy vọng những thông tin trên sẽ giúp bạn tính toán thời gian cần thiết để tải dữ liệu lên AWS.