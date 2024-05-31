##
## Control Flow with if / else and Conditional Operators
### Control Flow với `if`, `else`, và Các Toán Tử Điều Kiện

Control flow (luồng điều khiển) là một trong những khái niệm quan trọng trong lập trình, giúp bạn điều hướng luồng thực thi của chương trình dựa trên các điều kiện cụ thể. Python cung cấp các câu lệnh `if`, `elif`, và `else` để thực hiện điều này.

#### Cấu trúc cơ bản của `if`, `elif`, và `else`

1. **`if` Statement**:
   - Dùng để kiểm tra một điều kiện. Nếu điều kiện đúng (True), khối lệnh bên trong `if` sẽ được thực hiện.
   ```python
   if condition:
       # Khối lệnh được thực hiện nếu condition là True
       pass
   ```

2. **`elif` Statement**:
   - Dùng để kiểm tra thêm các điều kiện nếu điều kiện trong `if` là sai (False).
   ```python
   if condition1:
       # Khối lệnh được thực hiện nếu condition1 là True
       pass
   elif condition2:
       # Khối lệnh được thực hiện nếu condition1 là False và condition2 là True
       pass
   ```

3. **`else` Statement**:
   - Dùng để thực hiện khối lệnh nếu tất cả các điều kiện trên là sai (False).
   ```python
   if condition1:
       # Khối lệnh được thực hiện nếu condition1 là True
       pass
   elif condition2:
       # Khối lệnh được thực hiện nếu condition1 là False và condition2 là True
       pass
   else:
       # Khối lệnh được thực hiện nếu tất cả các điều kiện trên đều là False
       pass
   ```

#### Ví dụ Cụ Thể:

```python
age = 18

if age < 18:
    print("You are a minor.")
elif age == 18:
    print("You are exactly 18 years old.")
else:
    print("You are an adult.")
```

Trong ví dụ trên:
- Nếu `age` nhỏ hơn 18, chương trình sẽ in ra "You are a minor."
- Nếu `age` bằng 18, chương trình sẽ in ra "You are exactly 18 years old."
- Nếu `age` lớn hơn 18, chương trình sẽ in ra "You are an adult."

### Toán Tử Điều Kiện

Các toán tử điều kiện trong Python bao gồm:

1. **Toán tử so sánh**:
   - `==`: Bằng nhau
   - `!=`: Khác nhau
   - `<`: Nhỏ hơn
   - `<=`: Nhỏ hơn hoặc bằng
   - `>`: Lớn hơn
   - `>=`: Lớn hơn hoặc bằng
   ```python
   x = 10
   y = 20

   print(x == y)  # False
   print(x != y)  # True
   print(x < y)   # True
   print(x <= y)  # True
   print(x > y)   # False
   print(x >= y)  # False
   ```

2. **Toán tử logic**:
   - `and`: Trả về True nếu cả hai điều kiện đều đúng
   - `or`: Trả về True nếu ít nhất một trong hai điều kiện đúng
   - `not`: Đảo ngược giá trị logic của điều kiện
   ```python
   x = 5
   y = 10
   z = 15

   print(x < y and y < z)  # True
   print(x < y or y > z)   # True
   print(not(x < y))       # False
   ```

### Ví dụ Kết Hợp:

```python
x = 15

if x % 2 == 0:
    print("x is even")
else:
    print("x is odd")

# Kiểm tra nhiều điều kiện
score = 85

if score >= 90:
    grade = 'A'
elif score >= 80:
    grade = 'B'
elif score >= 70:
    grade = 'C'
elif score >= 60:
    grade = 'D'
else:
    grade = 'F'

print(f"Your grade is {grade}")
```

### Nested if Statements (Lồng nhau)

Bạn có thể lồng các câu lệnh `if` bên trong nhau để kiểm tra nhiều điều kiện phức tạp.

```python
num = 10

if num > 0:
    print("The number is positive")
    if num % 2 == 0:
        print("The number is even")
    else:
        print("The number is odd")
else:
    print("The number is not positive")
```

Trong ví dụ trên:
- Đầu tiên, chương trình kiểm tra xem `num` có lớn hơn 0 hay không.
- Nếu đúng, chương trình tiếp tục kiểm tra xem `num` có phải là số chẵn hay không và in ra kết quả phù hợp.
- Nếu `num` không lớn hơn 0, chương trình sẽ in ra "The number is not positive."

Control flow với `if`, `elif`, và `else` cùng các toán tử điều kiện giúp bạn kiểm soát luồng thực thi của chương trình một cách linh hoạt và hiệu quả.
## 