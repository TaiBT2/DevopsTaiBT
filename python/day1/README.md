## SUMARY
1. **Print Console**
2. **Python variable**
3. **Python Input function**
## PRINT CONSOLE
In Python, việc in ra console rất đơn giản và chủ yếu sử dụng hàm `print()`. Dưới đây là một số ví dụ cơ bản và nâng cao về cách sử dụng hàm `print()`.

### 1. Cú pháp cơ bản

1. **In một chuỗi văn bản:**
   ```python
   print("Hello, world!")
   ```

2. **In nhiều giá trị cùng một lúc:**
   ```python
   print("Hello", "world", 123)
   ```
   - Các giá trị được ngăn cách bằng dấu phẩy sẽ được in ra với khoảng trắng giữa chúng.

### 2. Định dạng chuỗi

1. **Sử dụng toán tử `%`:**
   ```python
   name = "Alice"
   age = 25
   print("Name: %s, Age: %d" % (name, age))
   ```

2. **Sử dụng phương thức `str.format()`:**
   ```python
   name = "Bob"
   age = 30
   print("Name: {}, Age: {}".format(name, age))
   ```

3. **Sử dụng f-string (Python 3.6+):**
   ```python
   name = "Charlie"
   age = 35
   print(f"Name: {name}, Age: {age}")
   ```

### 3. Tùy chỉnh cách in

1. **Sử dụng `sep` để thay đổi ký tự ngăn cách:**
   ```python
   print("Hello", "world", sep="-")
   ```
   - Kết quả: `Hello-world`

2. **Sử dụng `end` để thay đổi ký tự kết thúc:**
   ```python
   print("Hello", end=" ")
   print("world")
   ```
   - Kết quả: `Hello world` (hai dòng liền nhau)

3. **In với `flush` để ép buộc xuất ngay lập tức:**
   ```python
   import time
   for i in range(5):
       print(i, end=' ', flush=True)
       time.sleep(1)
   ```
   - Số được in ra ngay lập tức và có khoảng dừng một giây giữa các lần in.

### 4. In ra lỗi hoặc thông tin khác

1. **Sử dụng `sys.stderr` để in ra lỗi:**
   ```python
   import sys
   print("This is an error message", file=sys.stderr)
   ```

### 5. In đối tượng và cấu trúc dữ liệu

1. **In danh sách:**
   ```python
   my_list = [1, 2, 3, 4]
   print(my_list)
   ```

2. **In từ điển:**
   ```python
   my_dict = {"name": "Alice", "age": 25}
   print(my_dict)
   ```

3. **In đối tượng tùy chỉnh:**
   ```python
   class Person:
       def __init__(self, name, age):
           self.name = name
           self.age = age

       def __repr__(self):
           return f"Person(name={self.name}, age={self.age})"

   person = Person("Alice", 25)
   print(person)
   ```

### 6. Ví dụ đầy đủ

```python
def main():
    # In chuỗi đơn giản
    print("Hello, world!")

    # In nhiều giá trị
    print("Python", "is", "fun!")

    # Sử dụng f-string
    name = "Alice"
    age = 25
    print(f"Name: {name}, Age: {age}")

    # Tùy chỉnh ký tự ngăn cách và ký tự kết thúc
    print("Python", "is", "fun!", sep="-", end="!!!\n")

    # In danh sách và từ điển
    my_list = [1, 2, 3, 4]
    my_dict = {"name": "Bob", "age": 30}
    print(my_list)
    print(my_dict)

    # In ra lỗi
    import sys
    print("This is an error message", file=sys.stderr)

    # In với ép buộc xuất ngay lập tức
    import time
    for i in range(5):
        print(i, end=' ', flush=True)
        time.sleep(1)
    print()

if __name__ == "__main__":
    main()
```

### Tổng kết

Hàm `print()` trong Python rất linh hoạt và mạnh mẽ, cho phép bạn in ra console với nhiều định dạng và tùy chỉnh khác nhau. Bạn có thể sử dụng nó để in chuỗi văn bản, giá trị số, cấu trúc dữ liệu, đối tượng tùy chỉnh và thậm chí là thông báo lỗi. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần thêm trợ giúp, hãy cho tôi biết!
## Python Variable
Trong Python, biến (variable) là tên được sử dụng để tham chiếu đến một giá trị lưu trữ trong bộ nhớ. Dưới đây là cách sử dụng biến trong Python, bao gồm các quy tắc đặt tên, các kiểu dữ liệu khác nhau, và một số ví dụ minh họa.

### 1. Đặt tên biến

- Tên biến phải bắt đầu bằng một chữ cái (a-z, A-Z) hoặc dấu gạch dưới (_).
- Các ký tự tiếp theo có thể là chữ cái, số (0-9) hoặc dấu gạch dưới.
- Tên biến phân biệt chữ hoa chữ thường (ví dụ: `myVar` và `myvar` là hai biến khác nhau).
- Không sử dụng các từ khóa (keywords) của Python làm tên biến (như `class`, `for`, `if`, `else`, v.v.).

Ví dụ về tên biến hợp lệ và không hợp lệ:
```python
valid_variable = 10
_valid_variable = 20
validVariable123 = 30

# Không hợp lệ
# 1st_variable = 40  # Bắt đầu bằng số
# variable-name = 50 # Sử dụng dấu gạch ngang
# class = 60         # Từ khóa của Python
```

### 2. Khai báo và gán giá trị cho biến

Trong Python, bạn không cần khai báo kiểu dữ liệu của biến trước khi sử dụng. Bạn chỉ cần gán một giá trị cho biến và Python sẽ tự động xác định kiểu dữ liệu của nó.

```python
# Gán giá trị số nguyên
x = 10
print(x)  # Output: 10

# Gán giá trị số thực
y = 3.14
print(y)  # Output: 3.14

# Gán giá trị chuỗi
name = "Alice"
print(name)  # Output: Alice

# Gán giá trị boolean
is_active = True
print(is_active)  # Output: True
```

### 3. Các kiểu dữ liệu cơ bản

Python hỗ trợ nhiều kiểu dữ liệu khác nhau, bao gồm:

- Số nguyên (Integer): `int`
- Số thực (Floating-point): `float`
- Chuỗi (String): `str`
- Boolean: `bool`
- Danh sách (List): `list`
- Bộ (Tuple): `tuple`
- Từ điển (Dictionary): `dict`
- Tập hợp (Set): `set`

Ví dụ:
```python
# Số nguyên
x = 42
print(type(x))  # Output: <class 'int'>

# Số thực
y = 3.14159
print(type(y))  # Output: <class 'float'>

# Chuỗi
name = "Alice"
print(type(name))  # Output: <class 'str'>

# Boolean
is_valid = True
print(type(is_valid))  # Output: <class 'bool'>

# Danh sách
numbers = [1, 2, 3, 4, 5]
print(type(numbers))  # Output: <class 'list'>

# Bộ
coordinates = (10.0, 20.0)
print(type(coordinates))  # Output: <class 'tuple'>

# Từ điển
person = {"name": "Alice", "age": 25}
print(type(person))  # Output: <class 'dict'>

# Tập hợp
unique_numbers = {1, 2, 3, 4, 5}
print(type(unique_numbers))  # Output: <class 'set'>
```

### 4. Đa gán (Multiple Assignment)

Python cho phép gán nhiều biến cùng lúc trong một dòng lệnh.

```python
a, b, c = 1, 2, 3
print(a)  # Output: 1
print(b)  # Output: 2
print(c)  # Output: 3

# Hoán đổi giá trị của hai biến
a, b = b, a
print(a)  # Output: 2
print(b)  # Output: 1
```

### 5. Gán giá trị mặc định cho các biến

Bạn có thể sử dụng các giá trị mặc định khi khai báo biến, đặc biệt là trong các hàm.

```python
def greet(name="Guest"):
    print(f"Hello, {name}!")

greet("Alice")  # Output: Hello, Alice!
greet()         # Output: Hello, Guest!
```

### 6. Biến cục bộ và biến toàn cục

- **Biến cục bộ (local variable)**: Được khai báo bên trong một hàm và chỉ có thể được truy cập từ bên trong hàm đó.
- **Biến toàn cục (global variable)**: Được khai báo bên ngoài tất cả các hàm và có thể được truy cập từ bất kỳ đâu trong chương trình.

```python
global_var = "I am global"

def my_function():
    local_var = "I am local"
    print(local_var)       # Output: I am local
    print(global_var)      # Output: I am global

my_function()
# print(local_var)        # Lỗi: NameError: name 'local_var' is not defined
print(global_var)          # Output: I am global
```

Nếu bạn muốn thay đổi biến toàn cục bên trong hàm, bạn phải sử dụng từ khóa `global`:

```python
counter = 0

def increment():
    global counter
    counter += 1

increment()
print(counter)  # Output: 1
```

### Tổng kết

Biến là một khái niệm cơ bản nhưng rất quan trọng trong Python. Hiểu cách khai báo, gán giá trị và sử dụng biến giúp bạn viết mã hiệu quả và dễ hiểu. Nếu bạn có bất kỳ câu hỏi cụ thể nào về biến hoặc cần thêm ví dụ, hãy cho tôi biết!
## Python input function
Trong Python, hàm `input()` được sử dụng để lấy dữ liệu đầu vào từ người dùng thông qua bàn phím. Dưới đây là một hướng dẫn chi tiết về cách sử dụng hàm `input()`, bao gồm các ví dụ minh họa.

### 1. Cú pháp cơ bản

Cú pháp cơ bản của hàm `input()`:
```python
variable = input(prompt)
```
- `prompt` (không bắt buộc): Là một chuỗi văn bản hiển thị cho người dùng trước khi nhận đầu vào.

### 2. Ví dụ cơ bản

1. **Nhận một chuỗi từ người dùng:**
   ```python
   name = input("Enter your name: ")
   print(f"Hello, {name}!")
   ```

2. **Nhận một số từ người dùng và chuyển đổi sang kiểu số nguyên:**
   ```python
   age = int(input("Enter your age: "))
   print(f"You are {age} years old.")
   ```

3. **Nhận một số thực từ người dùng và chuyển đổi sang kiểu số thực:**
   ```python
   height = float(input("Enter your height in meters: "))
   print(f"Your height is {height} meters.")
   ```

### 3. Xử lý lỗi đầu vào

Khi nhận đầu vào từ người dùng, luôn có khả năng xảy ra lỗi nếu người dùng nhập dữ liệu không đúng định dạng mong đợi. Bạn có thể sử dụng câu lệnh `try` và `except` để xử lý các lỗi này.

1. **Xử lý lỗi khi người dùng nhập một số không phải là số nguyên:**
   ```python
   try:
       age = int(input("Enter your age: "))
       print(f"You are {age} years old.")
   except ValueError:
       print("Invalid input! Please enter a valid number.")
   ```

2. **Xử lý lỗi khi người dùng nhập một số không phải là số thực:**
   ```python
   try:
       height = float(input("Enter your height in meters: "))
       print(f"Your height is {height} meters.")
   except ValueError:
       print("Invalid input! Please enter a valid number.")
   ```

### 4. Ví dụ nâng cao

1. **Nhận nhiều giá trị từ người dùng và xử lý chúng:**
   ```python
   # Nhận ba số từ người dùng và tính tổng
   numbers = input("Enter three numbers separated by space: ").split()
   try:
       num1 = float(numbers[0])
       num2 = float(numbers[1])
       num3 = float(numbers[2])
       total = num1 + num2 + num3
       print(f"The total is: {total}")
   except (ValueError, IndexError):
       print("Invalid input! Please enter three valid numbers.")
   ```

2. **Nhận một biểu thức toán học và tính giá trị của nó:**
   ```python
   import math

   expression = input("Enter a mathematical expression (e.g., 2 + 2): ")
   try:
       result = eval(expression)
       print(f"The result is: {result}")
   except Exception as e:
       print(f"Invalid expression! {e}")
   ```

   **Lưu ý:** Sử dụng `eval()` có thể nguy hiểm nếu không kiểm tra kỹ đầu vào, vì nó sẽ thực thi bất kỳ mã Python nào được truyền vào. Chỉ sử dụng `eval()` với đầu vào đáng tin cậy hoặc thực hiện các biện pháp bảo vệ cần thiết.

### 5. Ví dụ đầy đủ

Dưới đây là một chương trình đầy đủ kết hợp nhiều khía cạnh đã thảo luận:

```python
def main():
    # Nhận tên người dùng
    name = input("Enter your name: ")
    print(f"Hello, {name}!")

    # Nhận tuổi người dùng
    try:
        age = int(input("Enter your age: "))
        print(f"You are {age} years old.")
    except ValueError:
        print("Invalid input! Please enter a valid number.")

    # Nhận chiều cao người dùng
    try:
        height = float(input("Enter your height in meters: "))
        print(f"Your height is {height} meters.")
    except ValueError:
        print("Invalid input! Please enter a valid number.")

    # Nhận ba số từ người dùng và tính tổng
    numbers = input("Enter three numbers separated by space: ").split()
    try:
        num1 = float(numbers[0])
        num2 = float(numbers[1])
        num3 = float(numbers[2])
        total = num1 + num2 + num3
        print(f"The total is: {total}")
    except (ValueError, IndexError):
        print("Invalid input! Please enter three valid numbers.")

    # Nhận một biểu thức toán học và tính giá trị của nó
    expression = input("Enter a mathematical expression (e.g., 2 + 2): ")
    try:
        result = eval(expression)
        print(f"The result is: {result}")
    except Exception as e:
        print(f"Invalid expression! {e}")

if __name__ == "__main__":
    main()
```

### Tổng kết

Hàm `input()` là công cụ cơ bản và hữu ích để nhận dữ liệu đầu vào từ người dùng trong Python. Việc hiểu và sử dụng đúng cách hàm này sẽ giúp bạn tạo ra các chương trình tương tác và linh hoạt. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần thêm ví dụ, hãy cho tôi biết!