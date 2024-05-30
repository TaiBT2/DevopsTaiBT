## Cấu trúc thư mục trong terraform
Phân chia thư mục trong Terraform là một phương pháp tổ chức mã nguồn để quản lý cơ sở hạ tầng theo cách dễ dàng hơn, có thể mở rộng và bảo trì lâu dài. Một cách tổ chức tốt sẽ giúp bạn quản lý tài nguyên dễ dàng, đảm bảo tính nhất quán và tránh xung đột khi làm việc với nhiều môi trường (như phát triển, thử nghiệm, và sản xuất). Dưới đây là một hướng dẫn chi tiết về cách phân chia thư mục trong Terraform.

### 1. Cấu trúc thư mục cơ bản

Một cách tổ chức cơ bản và phổ biến là phân chia theo môi trường. Dưới đây là một ví dụ về cấu trúc thư mục theo môi trường:

```plaintext
terraform/
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

### 2. Giải thích chi tiết

#### `envs/`

Thư mục `envs` chứa các môi trường khác nhau như `dev`, `staging`, và `prod`. Mỗi môi trường sẽ có cấu hình Terraform riêng biệt để triển khai cơ sở hạ tầng của mình.

- **`main.tf`**: Chứa định nghĩa tài nguyên cơ bản cho môi trường đó.
- **`variables.tf`**: Định nghĩa các biến cần thiết cho môi trường.
- **`outputs.tf`**: Định nghĩa các giá trị đầu ra cần thiết.
- **`terraform.tfvars`**: Chứa giá trị cụ thể của các biến cho môi trường đó.

#### `modules/`

Thư mục `modules` chứa các module dùng chung cho các môi trường khác nhau. Mỗi module là một thành phần cơ sở hạ tầng riêng biệt (ví dụ: VPC, EC2, S3).

- **`vpc/`, `ec2/`, `s3/`**: Mỗi thư mục là một module riêng biệt với các tệp `main.tf`, `variables.tf`, và `outputs.tf`.


### Tổng kết

Phân chia thư mục trong Terraform giúp quản lý cơ sở hạ tầng một cách có tổ chức và dễ dàng bảo trì. Bằng cách sử dụng các thư mục môi trường (`envs`) và module dùng chung (`modules`), bạn có thể tái sử dụng mã nguồn và đảm bảo tính nhất quán giữa các môi trường. Điều này đặc biệt quan trọng khi quản lý các hệ thống phức tạp và làm việc trong các nhóm phát triển lớn. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần thêm trợ giúp, hãy cho tôi biết!
## Provider và resources
Trong Terraform, hai khái niệm quan trọng nhất mà bạn cần hiểu là Resource và Provider. Dưới đây là mô tả chi tiết và ví dụ về cách sử dụng chúng.

### 1. Providers

**Provider** trong Terraform là một plugin cho phép Terraform tương tác với các API của các dịch vụ đám mây và các dịch vụ khác. Mỗi provider có thể cung cấp nhiều loại tài nguyên (resources) khác nhau mà bạn có thể quản lý.

Ví dụ về một số provider phổ biến:
- AWS
- Google Cloud Platform (GCP)
- Microsoft Azure
- Kubernetes
- GitHub

#### Cách sử dụng Provider

1. **Khai báo provider:**

Để sử dụng một provider, bạn cần khai báo nó trong tệp cấu hình Terraform (`.tf`).

Ví dụ: Khai báo provider AWS:
```hcl
provider "aws" {
  region = "us-west-2"
}
```

Ví dụ: Khai báo provider Google Cloud Platform:
```hcl
provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}
```

2. **Cài đặt provider:**

Khi bạn khởi tạo Terraform trong thư mục chứa tệp cấu hình (`terraform init`), Terraform sẽ tự động tải về các provider cần thiết.

```sh
terraform init
```

### 2. Resources

**Resource** trong Terraform là các thành phần của cơ sở hạ tầng mà bạn muốn quản lý. Điều này có thể bao gồm các máy ảo, các cơ sở dữ liệu, các mạng ảo, v.v.

#### Cách sử dụng Resource

1. **Khai báo resource:**

Ví dụ: Tạo một instance EC2 trong AWS:
```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

Ví dụ: Tạo một bucket trong Google Cloud Storage:
```hcl
resource "google_storage_bucket" "example" {
  name     = "example-bucket"
  location = "US"
}
```

2. **Khai báo biến và đầu ra:**

Bạn có thể khai báo các biến (`variables`) và các giá trị đầu ra (`outputs`) để quản lý cấu hình linh hoạt hơn.

Ví dụ về khai báo biến:
```hcl
variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
}
```

Ví dụ về khai báo giá trị đầu ra:
```hcl
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}
```

3. **Sử dụng resource trong thực tế:**

Một ví dụ hoàn chỉnh kết hợp tất cả các yếu tố đã nói ở trên:

```hcl
# Khai báo provider
provider "aws" {
  region = "us-west-2"
}

# Khai báo biến
variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
}

# Khai báo resource
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  tags = {
    Name = "example-instance"
  }
}

# Khai báo giá trị đầu ra
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}
```

4. **Chạy Terraform:**

Để triển khai cơ sở hạ tầng đã khai báo, bạn thực hiện các lệnh Terraform sau:

- Khởi tạo Terraform:
  ```sh
  terraform init
  ```

- Xem trước các thay đổi sẽ được áp dụng:
  ```sh
  terraform plan
  ```

- Áp dụng các thay đổi để tạo tài nguyên:
  ```sh
  terraform apply
  ```

### Tổng kết

- **Providers** là các plugin cho phép Terraform tương tác với các dịch vụ đám mây và các API khác.
- **Resources** là các thành phần của cơ sở hạ tầng mà bạn muốn quản lý.

Việc hiểu và sử dụng đúng cách hai khái niệm này là cơ bản và quan trọng để quản lý cơ sở hạ tầng một cách hiệu quả với Terraform. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần thêm ví dụ, hãy cho tôi biết!
## Terraform state file
Trong Terraform, tệp trạng thái (state file) là một thành phần quan trọng để quản lý và theo dõi cơ sở hạ tầng của bạn. Tệp trạng thái lưu trữ thông tin về các tài nguyên đã được tạo và cấu hình bởi Terraform, giúp Terraform biết được trạng thái hiện tại của cơ sở hạ tầng và quyết định các thay đổi cần thiết khi bạn chạy các lệnh như `terraform apply`.

### 1. Tổng quan về Tệp Trạng thái

- **Lưu trữ trạng thái:** Tệp trạng thái giữ thông tin về cấu hình của bạn, các tài nguyên đã tạo, và các thuộc tính của chúng.
- **Theo dõi thay đổi:** Terraform sử dụng tệp trạng thái để so sánh cấu hình hiện tại với cấu hình mong muốn và xác định các thay đổi cần thiết.
- **Tăng tốc quá trình:** Tệp trạng thái giúp Terraform không cần phải liên hệ với API của nhà cung cấp dịch vụ để lấy thông tin về các tài nguyên mỗi khi chạy lệnh.

### 2. Vị trí của Tệp Trạng thái

Mặc định, tệp trạng thái được lưu trữ cục bộ trong tệp `terraform.tfstate` trong thư mục làm việc hiện tại. Tuy nhiên, trong môi trường làm việc nhóm hoặc khi làm việc với cơ sở hạ tầng lớn, việc lưu trữ tệp trạng thái cục bộ có thể gây ra các vấn đề về đồng bộ và bảo mật.

### 3. Lưu trữ Tệp Trạng thái Từ xa

Để khắc phục các vấn đề trên, Terraform hỗ trợ việc lưu trữ tệp trạng thái từ xa (remote state) thông qua các backends như Amazon S3, Azure Blob Storage, Google Cloud Storage, HashiCorp Consul, Terraform Cloud, v.v.

#### Ví dụ: Sử dụng Amazon S3 làm Backend

1. **Cấu hình Backend:**

   Tạo một tệp `backend.tf` và cấu hình backend S3 như sau:

   ```hcl
   terraform {
     backend "s3" {
       bucket         = "my-terraform-state-bucket"
       key            = "path/to/my/key"
       region         = "us-west-2"
       dynamodb_table = "my-lock-table"
     }
   }
   ```

   - `bucket`: Tên của bucket S3.
   - `key`: Đường dẫn đến tệp trạng thái trong bucket S3.
   - `region`: Vùng của bucket S3.
   - `dynamodb_table`: Tên của bảng DynamoDB để khóa trạng thái, tránh xung đột khi nhiều người dùng thao tác cùng lúc.

2. **Khởi tạo Backend:**

   Chạy lệnh `terraform init` để khởi tạo cấu hình backend.

   ```sh
   terraform init
   ```

### 4. Các Lệnh Liên Quan đến Tệp Trạng thái

- **`terraform state list`:** Liệt kê tất cả các tài nguyên trong tệp trạng thái.
  ```sh
  terraform state list
  ```

- **`terraform state show [resource]`:** Hiển thị chi tiết một tài nguyên cụ thể trong tệp trạng thái.
  ```sh
  terraform state show aws_instance.example
  ```

- **`terraform state mv [source] [destination]`:** Di chuyển tài nguyên trong tệp trạng thái.
  ```sh
  terraform state mv aws_instance.example aws_instance.new_example
  ```

- **`terraform state rm [resource]`:** Xóa một tài nguyên khỏi tệp trạng thái.
  ```sh
  terraform state rm aws_instance.example
  ```

- **`terraform state pull`:** Tải xuống tệp trạng thái từ backend từ xa và hiển thị nội dung.
  ```sh
  terraform state pull
  ```

- **`terraform state push`:** Đẩy tệp trạng thái cục bộ lên backend từ xa.
  ```sh
  terraform state push
  ```

### 5. Mã hóa và Bảo mật Tệp Trạng thái

Vì tệp trạng thái chứa thông tin nhạy cảm (như mật khẩu, khóa API), việc bảo mật tệp trạng thái là rất quan trọng. Khi lưu trữ tệp trạng thái từ xa, bạn nên:

- **Mã hóa tệp trạng thái:** Sử dụng các tính năng mã hóa của backend lưu trữ. Ví dụ, với S3, bạn có thể sử dụng mã hóa phía server (SSE).
- **Kiểm soát truy cập:** Sử dụng các chính sách IAM hoặc ACL để kiểm soát truy cập vào bucket lưu trữ tệp trạng thái.
- **Sử dụng khóa trạng thái:** Sử dụng DynamoDB hoặc các hệ thống khóa tương tự để ngăn ngừa xung đột khi nhiều người dùng thao tác cùng lúc.

### Ví dụ Mã hóa và Kiểm soát Truy cập với S3 và DynamoDB

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/key"
    region         = "us-west-2"
    dynamodb_table = "my-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}
```

### Tổng kết

Tệp trạng thái là thành phần cốt lõi trong Terraform, giúp quản lý và theo dõi trạng thái cơ sở hạ tầng. Việc sử dụng backend từ xa cho tệp trạng thái giúp bạn làm việc hiệu quả hơn trong môi trường nhóm và bảo mật tốt hơn. Hãy đảm bảo mã hóa và kiểm soát truy cập tệp trạng thái để bảo vệ thông tin nhạy cảm của bạn. Nếu bạn có bất kỳ câu hỏi cụ thể nào hoặc cần thêm ví dụ, hãy cho tôi biết!
## Terraform Varriable
Trong Terraform, biến (variable) là một thành phần quan trọng giúp bạn làm cho cấu hình của mình linh hoạt và có thể tái sử dụng. Biến cho phép bạn truyền các giá trị khác nhau vào cấu hình Terraform mà không cần thay đổi mã nguồn của cấu hình.

### 1. Khai báo Biến

Để khai báo một biến trong Terraform, bạn sử dụng khối `variable`. Khối này có thể bao gồm các thuộc tính như `description`, `type`, `default`, và `validation`.

Ví dụ về khai báo biến:

```hcl
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}
```

### 2. Sử dụng Biến trong Cấu hình

Sau khi khai báo, bạn có thể sử dụng biến bằng cách tham chiếu đến nó với cú pháp `var.<variable_name>`.

Ví dụ:

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  tags = {
    Name = "example-instance"
  }
}
```

### 3. Gán Giá trị cho Biến

Có nhiều cách để gán giá trị cho biến trong Terraform:

#### a. Sử dụng Tệp `terraform.tfvars`

Tạo một tệp có tên `terraform.tfvars` và định nghĩa các biến bên trong:

```hcl
instance_type = "t2.large"
```

#### b. Sử dụng Dòng lệnh

Bạn có thể truyền các giá trị biến trực tiếp từ dòng lệnh khi chạy lệnh `terraform plan` hoặc `terraform apply`:

```sh
terraform apply -var="instance_type=t2.large"
```

#### c. Sử dụng Biến Môi trường

Bạn cũng có thể sử dụng biến môi trường để gán giá trị cho biến Terraform. Biến môi trường phải có tên theo cú pháp `TF_VAR_<variable_name>`:

```sh
export TF_VAR_instance_type="t2.large"
terraform apply
```

#### d. Sử dụng Tệp `*.auto.tfvars`

Tạo một tệp có đuôi `.auto.tfvars` và Terraform sẽ tự động tải tệp này. Ví dụ: `variables.auto.tfvars`.

```hcl
instance_type = "t2.large"
```

### 4. Các Loại Biến

Terraform hỗ trợ nhiều loại biến khác nhau như `string`, `number`, `bool`, `list`, `map`, `set`, `object`, `tuple`.

#### a. Biến chuỗi (String)

```hcl
variable "instance_type" {
  type = string
}
```

#### b. Biến số (Number)

```hcl
variable "instance_count" {
  type = number
  default = 1
}
```

#### c. Biến boolean (Bool)

```hcl
variable "enable_monitoring" {
  type    = bool
  default = true
}
```

#### d. Biến danh sách (List)

```hcl
variable "availability_zones" {
  type = list(string)
  default = ["us-west-1a", "us-west-1b"]
}
```

#### e. Biến bản đồ (Map)

```hcl
variable "instance_tags" {
  type = map(string)
  default = {
    Name = "example-instance"
    Environment = "development"
  }
}
```

#### f. Biến đối tượng (Object)

```hcl
variable "instance_config" {
  type = object({
    instance_type = string
    ami           = string
    tags          = map(string)
  })
  default = {
    instance_type = "t2.micro"
    ami           = "ami-0c55b159cbfafe1f0"
    tags          = {
      Name = "example-instance"
    }
  }
}
```

#### g. Biến tập hợp (Set)

```hcl
variable "security_groups" {
  type = set(string)
  default = ["sg-12345678", "sg-87654321"]
}
```

### 5. Ví dụ Hoàn chỉnh

Dưới đây là một ví dụ hoàn chỉnh về cách sử dụng biến trong một cấu hình Terraform:

#### `variables.tf`

```hcl
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "instance_tags" {
  description = "Tags to apply to the instance"
  type = map(string)
  default = {
    Name = "example-instance"
    Environment = "development"
  }
}
```

#### `main.tf`

```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  tags = var.instance_tags
}
```

#### `terraform.tfvars`

```hcl
region        = "us-west-2"
instance_type = "t3.medium"
instance_tags = {
  Name        = "example-instance"
  Environment = "production"
}
```

### Tổng kết

Biến trong Terraform giúp bạn làm cho cấu hình của mình linh hoạt và dễ tái sử dụng hơn. Bằng cách sử dụng biến, bạn có thể dễ dàng thay đổi cấu hình mà không cần thay đổi mã nguồn. Các biến có thể được gán giá trị theo nhiều cách khác nhau, bao gồm tệp `terraform.tfvars`, dòng lệnh, biến môi trường và tệp `*.auto.tfvars`. Việc hiểu và sử dụng biến đúng cách sẽ giúp bạn quản lý cơ sở hạ tầng hiệu quả hơn với Terraform. Nếu bạn có bất kỳ câu hỏi nào hoặc cần thêm ví dụ cụ thể, hãy cho tôi biết!