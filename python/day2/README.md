## SUMARY
## Chuyển đổi kiểu dữ liệu
### TypeError (Lỗi Kiểu Dữ Liệu)
**TypeError** là một lỗi xuất hiện khi bạn cố gắng thực hiện một phép toán hoặc thao tác trên các kiểu dữ liệu không hợp lệ. Python phát hiện và thông báo lỗi này để ngăn chặn các hoạt động không hợp lý hoặc không khả thi.

#### Ví dụ về TypeError:
```python
# Cố gắng cộng một chuỗi và một số nguyên
a = "Hello"
b = 5
print(a + b)  # TypeError: can only concatenate str (not "int") to str
```

### Type Checking (Kiểm Tra Kiểu Dữ Liệu)
**Type checking** là quá trình xác định kiểu dữ liệu của một biến hoặc một giá trị trong quá trình chạy chương trình. Python là một ngôn ngữ lập trình động, nghĩa là kiểu dữ liệu được xác định trong thời gian chạy, không phải trong thời gian biên dịch.

#### Cách kiểm tra kiểu dữ liệu:
- Sử dụng hàm `type()` để kiểm tra kiểu dữ liệu của một biến.
- Sử dụng `isinstance()` để kiểm tra xem một biến có thuộc một kiểu dữ liệu nhất định hay không.

#### Ví dụ về type checking:
```python
# Sử dụng type() để kiểm tra kiểu dữ liệu
a = 42
print(type(a))  # Output: <class 'int'>

# Sử dụng isinstance() để kiểm tra xem biến có phải là một kiểu dữ liệu nhất định không
b = 3.14
print(isinstance(b, float))  # Output: True
```

### Type Conversion (Chuyển Đổi Kiểu Dữ Liệu)
**Type conversion** là quá trình chuyển đổi một giá trị từ kiểu dữ liệu này sang kiểu dữ liệu khác. Python cung cấp các hàm dựng sẵn để thực hiện các chuyển đổi này.

#### Chuyển đổi kiểu dữ liệu phổ biến:
- `int()`: Chuyển đổi giá trị sang kiểu số nguyên.
- `float()`: Chuyển đổi giá trị sang kiểu số thực.
- `str()`: Chuyển đổi giá trị sang kiểu chuỗi.
- `bool()`: Chuyển đổi giá trị sang kiểu boolean.

#### Ví dụ về type conversion:
```python
# Chuyển đổi số thực sang số nguyên
a = 3.14
b = int(a)  # b sẽ là 3

# Chuyển đổi số nguyên sang chuỗi
c = 42
d = str(c)  # d sẽ là "42"

# Chuyển đổi chuỗi sang số thực
e = "3.14"
f = float(e)  # f sẽ là 3.14

# Chuyển đổi số nguyên sang boolean
g = 0
h = bool(g)  # h sẽ là False (vì 0 được coi là False trong boolean)
```

### Các lưu ý khi chuyển đổi kiểu dữ liệu:
- Không phải lúc nào cũng có thể chuyển đổi một kiểu dữ liệu này sang kiểu dữ liệu khác mà không gặp lỗi. Ví dụ, chuyển đổi một chuỗi không phải số sang kiểu số sẽ gây ra lỗi.
- Khi chuyển đổi từ kiểu số thực sang kiểu số nguyên, phần thập phân sẽ bị bỏ qua (không làm tròn).

### Ví dụ với lỗi TypeError và cách giải quyết bằng type conversion:
```python
# Ví dụ với TypeError
a = "123"
b = 456
# print(a + b)  # TypeError: can only concatenate str (not "int") to str

# Giải quyết bằng cách chuyển đổi kiểu dữ liệu
a = int(a)  # Chuyển đổi chuỗi "123" sang số nguyên 123
print(a + b)  # Output: 579
```

Hiểu rõ về TypeError, type checking và type conversion sẽ giúp bạn tránh các lỗi liên quan đến kiểu dữ liệu và viết mã Python an toàn và hiệu quả hơn.
## Mathematical Operations in Python
Python cung cấp một loạt các phép toán số học cơ bản và nâng cao cho các kiểu dữ liệu số. Dưới đây là tổng quan về các phép toán số học phổ biến trong Python:

### Phép Toán Số Học Cơ Bản

1. **Phép cộng (`+`)**:
   - Dùng để cộng hai số.
   - Ví dụ:
     ```python
     result = 5 + 3  # result sẽ là 8
     ```

2. **Phép trừ (`-`)**:
   - Dùng để trừ số thứ hai từ số thứ nhất.
   - Ví dụ:
     ```python
     result = 10 - 4  # result sẽ là 6
     ```

3. **Phép nhân (`*`)**:
   - Dùng để nhân hai số.
   - Ví dụ:
     ```python
     result = 7 * 6  # result sẽ là 42
     ```

4. **Phép chia (`/`)**:
   - Dùng để chia số thứ nhất cho số thứ hai và trả về kết quả là số thực.
   - Ví dụ:
     ```python
     result = 8 / 2  # result sẽ là 4.0
     ```

5. **Phép chia lấy phần nguyên (`//`)**:
   - Dùng để chia số thứ nhất cho số thứ hai và lấy phần nguyên của kết quả.
   - Ví dụ:
     ```python
     result = 7 // 3  # result sẽ là 2
     ```

6. **Phép chia lấy phần dư (`%`)**:
   - Dùng để lấy phần dư khi chia số thứ nhất cho số thứ hai.
   - Ví dụ:
     ```python
     result = 7 % 3  # result sẽ là 1
     ```

7. **Phép lũy thừa (`**`)**:
   - Dùng để tính lũy thừa của một số với một số mũ.
   - Ví dụ:
     ```python
     result = 2 ** 3  # result sẽ là 8
     ```

### Các Hàm Toán Học Nâng Cao

Python cung cấp module `math` để thực hiện các phép toán nâng cao.

1. **Sử dụng module `math`**:
   - Import module `math` để truy cập các hàm toán học nâng cao.
   - Ví dụ:
     ```python
     import math

     # Tính căn bậc hai
     result = math.sqrt(16)  # result sẽ là 4.0

     # Tính giai thừa
     result = math.factorial(5)  # result sẽ là 120

     # Tính giá trị của số pi
     pi_value = math.pi  # pi_value sẽ là 3.141592653589793

     # Tính sin của một góc (theo radian)
     result = math.sin(math.pi / 2)  # result sẽ là 1.0

     # Tính log cơ số e (logarit tự nhiên)
     result = math.log(2.71828)  # result sẽ xấp xỉ 1.0
     ```

### Một Số Ví Dụ Cụ Thể

1. **Tính diện tích của một hình tròn**:
   ```python
   import math

   radius = 5
   area = math.pi * (radius ** 2)
   print(area)  # Output: 78.53981633974483
   ```

2. **Tính tổng các số từ 1 đến n**:
   ```python
   n = 10
   total = (n * (n + 1)) // 2
   print(total)  # Output: 55
   ```

3. **Chuyển đổi độ sang radian và tính cos**:
   ```python
   import math

   degrees = 60
   radians = math.radians(degrees)
   cosine_value = math.cos(radians)
   print(cosine_value)  # Output: 0.5
   ```

### Một Số Lưu Ý:

- Khi làm việc với phép chia, cần chú ý đến việc chia cho số 0 vì điều này sẽ gây ra lỗi `ZeroDivisionError`.
- Các phép toán với số thực có thể dẫn đến các sai số do cách máy tính biểu diễn số thực.

Với các phép toán cơ bản và nâng cao này, bạn có thể thực hiện hầu hết các tính toán cần thiết trong các ứng dụng Python của mình.
## Number Manipulation and F Strings in Python
### Number Manipulation in Python

Python cung cấp nhiều công cụ và kỹ thuật để thao tác với số. Dưới đây là một số ví dụ về cách bạn có thể làm việc với số trong Python.

#### Làm tròn số
- **`round()`**: Làm tròn số đến số lượng chữ số thập phân xác định.
  ```python
  x = 3.14159
  rounded = round(x, 2)  # rounded sẽ là 3.14
  ```

- **`math.ceil()` và `math.floor()`**: Làm tròn lên hoặc làm tròn xuống.
  ```python
  import math

  x = 3.7
  ceil_value = math.ceil(x)   # ceil_value sẽ là 4
  floor_value = math.floor(x) # floor_value sẽ là 3
  ```

#### Giá trị tuyệt đối
- **`abs()`**: Trả về giá trị tuyệt đối của một số.
  ```python
  x = -5
  absolute_value = abs(x)  # absolute_value sẽ là 5
  ```

#### Phép tính modulo
- **`%`**: Trả về phần dư của phép chia.
  ```python
  x = 10
  y = 3
  remainder = x % y  # remainder sẽ là 1
  ```

#### Phép lũy thừa
- **`**`**: Dùng để tính lũy thừa.
  ```python
  base = 2
  exponent = 3
  result = base ** exponent  # result sẽ là 8
  ```

- **`pow()`**: Hàm tích hợp cho phép lũy thừa.
  ```python
  base = 2
  exponent = 3
  result = pow(base, exponent)  # result sẽ là 8
  ```

### F-strings (Formatted String Literals)

F-strings là cách thuận tiện và hiệu quả để định dạng chuỗi trong Python. Được giới thiệu trong Python 3.6, f-strings cho phép bạn chèn biểu thức bên trong dấu ngoặc nhọn `{}` trong chuỗi có chữ `f` ở đầu.

#### Cách sử dụng cơ bản
- **Định dạng số nguyên và số thực**:
  ```python
  name = "Alice"
  age = 30
  height = 5.678

  formatted_string = f"My name is {name} and I am {age} years old. My height is {height:.2f} feet."
  print(formatted_string)  # Output: My name is Alice and I am 30 years old. My height is 5.68 feet.
  ```

#### Các tùy chọn định dạng khác
- **Canh lề và độ rộng**:
  ```python
  number = 42
  formatted_string = f"The number is {number:>5}"  # Canh phải với độ rộng 5 ký tự
  print(formatted_string)  # Output: "The number is    42"
  ```

- **Định dạng số với dấu phân cách hàng nghìn**:
  ```python
  large_number = 1000000
  formatted_string = f"The large number is {large_number:,}"
  print(formatted_string)  # Output: "The large number is 1,000,000"
  ```

#### Chèn biểu thức phức tạp
- **Biểu thức trong f-strings**:
  ```python
  a = 5
  b = 10
  formatted_string = f"The sum of {a} and {b} is {a + b}"
  print(formatted_string)  # Output: "The sum of 5 and 10 is 15"
  ```

### Ví dụ toàn diện
Dưới đây là một ví dụ toàn diện sử dụng cả các thao tác với số và f-strings để tạo một chuỗi định dạng đẹp.

```python
import math

# Các giá trị và phép toán
radius = 7.5
area = math.pi * (radius ** 2)
circumference = 2 * math.pi * radius

# Sử dụng f-strings để định dạng kết quả
result_string = (
    f"Circle with radius {radius}:\n"
    f"  - Area: {area:.2f} square units\n"
    f"  - Circumference: {circumference:.2f} units"
)

print(result_string)
```

### Kết quả đầu ra
```plaintext
Circle with radius 7.5:
  - Area: 176.71 square units
  - Circumference: 47.12 units
```

F-strings và các kỹ thuật thao tác với số trong Python cung cấp cho bạn khả năng linh hoạt và hiệu quả để làm việc với dữ liệu số và định dạng kết quả một cách rõ ràng và dễ đọc.

