resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name
    acl    = var.bucket_acl
    tags = {
        Name = "my-bucket"
    }
    
}
