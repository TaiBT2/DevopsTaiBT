## Random Module
Python cung cấp module `random` để làm việc với các thao tác ngẫu nhiên, như sinh số ngẫu nhiên, chọn phần tử ngẫu nhiên từ danh sách, và nhiều hơn nữa. Dưới đây là một số hàm và ví dụ sử dụng phổ biến trong module `random`.

### Import Module

Đầu tiên, bạn cần import module `random` để sử dụng các hàm của nó.

```python
import random
```

### Sinh Số Ngẫu Nhiên

1. **Sinh số nguyên ngẫu nhiên trong một khoảng xác định**:
   - **`random.randint(a, b)`**: Trả về một số nguyên ngẫu nhiên N sao cho `a <= N <= b`.
     ```python
     random_int = random.randint(1, 10)
     print(random_int)  # Ví dụ: 7
     ```

2. **Sinh số thực ngẫu nhiên**:
   - **`random.random()`**: Trả về một số thực ngẫu nhiên N trong khoảng `[0.0, 1.0)`.
     ```python
     random_float = random.random()
     print(random_float)  # Ví dụ: 0.6823
     ```

   - **`random.uniform(a, b)`**: Trả về một số thực ngẫu nhiên N trong khoảng `[a, b]`.
     ```python
     random_uniform = random.uniform(1.5, 10.5)
     print(random_uniform)  # Ví dụ: 7.236
     ```

3. **Sinh số thực ngẫu nhiên theo phân phối Gaussian (phân phối chuẩn)**:
   - **`random.gauss(mu, sigma)`**: Trả về một số thực ngẫu nhiên theo phân phối Gaussian với trung bình `mu` và độ lệch chuẩn `sigma`.
     ```python
     random_gauss = random.gauss(0, 1)
     print(random_gauss)  # Ví dụ: -0.1245
     ```

### Chọn Phần Tử Ngẫu Nhiên Từ Danh Sách

1. **Chọn một phần tử ngẫu nhiên**:
   - **`random.choice(sequence)`**: Trả về một phần tử ngẫu nhiên từ `sequence`.
     ```python
     fruits = ['apple', 'banana', 'cherry', 'date']
     random_fruit = random.choice(fruits)
     print(random_fruit)  # Ví dụ: 'cherry'
     ```

2. **Chọn nhiều phần tử ngẫu nhiên không lặp lại**:
   - **`random.sample(sequence, k)`**: Trả về một danh sách gồm `k` phần tử ngẫu nhiên không lặp lại từ `sequence`.
     ```python
     random_sample = random.sample(fruits, 2)
     print(random_sample)  # Ví dụ: ['banana', 'date']
     ```

3. **Chọn nhiều phần tử ngẫu nhiên có lặp lại**:
   - **`random.choices(sequence, k)`**: Trả về một danh sách gồm `k` phần tử ngẫu nhiên có lặp lại từ `sequence`.
     ```python
     random_choices = random.choices(fruits, k=3)
     print(random_choices)  # Ví dụ: ['apple', 'apple', 'cherry']
     ```

### Trộn Ngẫu Nhiên Danh Sách

- **`random.shuffle(sequence)`**: Trộn các phần tử của danh sách `sequence` ngẫu nhiên.
  ```python
  deck = [1, 2, 3, 4, 5]
  random.shuffle(deck)
  print(deck)  # Ví dụ: [3, 1, 4, 5, 2]
  ```

### Đặt Hạt Giống (Seed) Cho Bộ Sinh Số Ngẫu Nhiên

Đặt hạt giống cho bộ sinh số ngẫu nhiên để đảm bảo kết quả có thể tái tạo được (ví dụ: trong các trường hợp kiểm thử).

- **`random.seed(a)`**: Đặt hạt giống cho bộ sinh số ngẫu nhiên.
  ```python
  random.seed(42)
  print(random.random())  # Ví dụ: 0.6394267984578837

  random.seed(42)
  print(random.random())  # Kết quả sẽ lại là: 0.6394267984578837
  ```

### Ví dụ Toàn Diện

Dưới đây là một ví dụ toàn diện sử dụng nhiều hàm từ module `random`.

```python
import random

# Sinh số nguyên ngẫu nhiên
print("Random integer between 1 and 10:", random.randint(1, 10))

# Sinh số thực ngẫu nhiên
print("Random float between 0 and 1:", random.random())

# Sinh số thực ngẫu nhiên trong khoảng xác định
print("Random float between 1.5 and 10.5:", random.uniform(1.5, 10.5))

# Sinh số theo phân phối Gaussian
print("Random Gaussian number with mean 0 and stddev 1:", random.gauss(0, 1))

# Chọn một phần tử ngẫu nhiên từ danh sách
fruits = ['apple', 'banana', 'cherry', 'date']
print("Random choice from list:", random.choice(fruits))

# Chọn nhiều phần tử ngẫu nhiên không lặp lại từ danh sách
print("Random sample of 2 from list:", random.sample(fruits, 2))

# Chọn nhiều phần tử ngẫu nhiên có lặp lại từ danh sách
print("Random choices of 3 from list:", random.choices(fruits, k=3))

# Trộn ngẫu nhiên danh sách
deck = [1, 2, 3, 4, 5]
random.shuffle(deck)
print("Shuffled list:", deck)

# Đặt hạt giống cho bộ sinh số ngẫu nhiên
random.seed(42)
print("Random number with seed 42:", random.random())
```
## Offset and Appending Items to Lists
### Offset and Appending Items to Lists in Python

In Python, lists are ordered collections of items which are mutable, meaning you can change their content. Let's explore how to use offsets (also known as indexing) to access elements and how to append items to lists.

### Accessing Elements with Offset (Indexing)

You can access elements of a list using their index. Indexing starts from 0 in Python.

#### Basic Indexing

```python
# Define a list
fruits = ['apple', 'banana', 'cherry', 'date']

# Access elements by index
print(fruits[0])  # Output: apple
print(fruits[1])  # Output: banana
print(fruits[2])  # Output: cherry
print(fruits[3])  # Output: date
```

#### Negative Indexing

Negative indexing allows you to access elements from the end of the list.

```python
# Access elements using negative index
print(fruits[-1])  # Output: date
print(fruits[-2])  # Output: cherry
print(fruits[-3])  # Output: banana
print(fruits[-4])  # Output: apple
```

#### Slicing

Slicing allows you to access a range of elements from the list.

```python
# Access a range of elements
print(fruits[1:3])  # Output: ['banana', 'cherry']
print(fruits[:2])   # Output: ['apple', 'banana']
print(fruits[2:])   # Output: ['cherry', 'date']
print(fruits[:])    # Output: ['apple', 'banana', 'cherry', 'date']
```

### Appending Items to Lists

You can add items to the end of a list using the `append()` method.

#### Using `append()`

```python
# Define a list
fruits = ['apple', 'banana', 'cherry']

# Append an item to the list
fruits.append('date')
print(fruits)  # Output: ['apple', 'banana', 'cherry', 'date']
```

### Extending Lists

You can add multiple items to a list using the `extend()` method.

```python
# Define a list
fruits = ['apple', 'banana', 'cherry']

# Extend the list with multiple items
fruits.extend(['date', 'elderberry'])
print(fruits)  # Output: ['apple', 'banana', 'cherry', 'date', 'elderberry']
```

### Inserting Items

You can insert an item at a specific index using the `insert()` method.

```python
# Define a list
fruits = ['apple', 'banana', 'cherry']

# Insert an item at a specific index
fruits.insert(1, 'blueberry')
print(fruits)  # Output: ['apple', 'blueberry', 'banana', 'cherry']
```

### Combining Lists

You can combine (concatenate) lists using the `+` operator.

```python
# Define two lists
list1 = ['apple', 'banana']
list2 = ['cherry', 'date']

# Combine lists
combined_list = list1 + list2
print(combined_list)  # Output: ['apple', 'banana', 'cherry', 'date']
```

### List Comprehension

List comprehension is a concise way to create lists.

```python
# Create a list of squares using list comprehension
squares = [x**2 for x in range(1, 6)]
print(squares)  # Output: [1, 4, 9, 16, 25]
```

### Example: Full Workflow

Here’s an example that demonstrates accessing, appending, and manipulating lists:

```python
# Create a list of numbers
numbers = [1, 2, 3, 4, 5]

# Access elements
first_element = numbers[0]  # Output: 1
last_element = numbers[-1]  # Output: 5

# Append a number
numbers.append(6)  # List is now [1, 2, 3, 4, 5, 6]

# Extend the list
numbers.extend([7, 8])  # List is now [1, 2, 3, 4, 5, 6, 7, 8]

# Insert a number at index 0
numbers.insert(0, 0)  # List is now [0, 1, 2, 3, 4, 5, 6, 7, 8]

# Slice the list
middle_numbers = numbers[3:6]  # Output: [3, 4, 5]

print("First element:", first_element)
print("Last element:", last_element)
print("Updated list:", numbers)
print("Middle numbers slice:", middle_numbers)
```

This example covers basic operations you can perform on lists in Python, providing a solid foundation for working with this essential data structure.

Kết quả sẽ thay đổi mỗi lần bạn chạy chương trình (trừ khi bạn đặt hạt giống), và bạn có thể thấy cách các hàm của module `random` được sử dụng để thao tác với các giá trị ngẫu nhiên.
