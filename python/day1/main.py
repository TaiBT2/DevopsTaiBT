# Practice with console
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
# Practice with  input function
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
