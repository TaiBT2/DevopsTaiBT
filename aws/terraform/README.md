# AWS Terraform Project

This project uses Terraform to provision and manage AWS resources including VPC, RDS, EKS, and Redis.

## Project Structure

The project is structured as follows:

- `main.tf`: Main Terraform configuration file.
- `variables.tf`: Declares the variables used in `main.tf`.
- `outputs.tf`: Declares the outputs of the Terraform configuration.
- `vpc/`: Contains Terraform configuration for creating a VPC.
- `rds/`: Contains Terraform configuration for creating an RDS instance.
- `eks/`: Contains Terraform configuration for creating an EKS cluster.
- `redis/`: Contains Terraform configuration for creating a Redis instance.

Each module has its own `main.tf`, `variables.tf`, and `outputs.tf` files.

## Prerequisites

- Terraform installed
- AWS account and AWS CLI configured

## Usage

1. Clone the repository.
2. Navigate to the project directory.
3. Initialize Terraform:

   ```
   terraform init
   ```

4. Validate the configuration:

   ```
   terraform validate
   ```

5. Plan the deployment:

   ```
   terraform plan
   ```

6. Apply the configuration:

   ```
   terraform apply
   ```

To destroy the resources when you're done, use:

```
terraform destroy
```

## Note

Please ensure you have the necessary AWS permissions to create and manage the resources defined in this project. Costs may be associated with the creation and ongoing usage of these AWS resources.