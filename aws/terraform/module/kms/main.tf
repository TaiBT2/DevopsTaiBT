resource "aws_kms_key" "example_key" {
    description             = var.description
    deletion_window_in_days = var.deletion_window_in_days
    enable_key_rotation     = var.enable_key_rotation
    is_enabled              = var.is_enabled
    policy                  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::123456789012:user/example-user"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF

    tags = var.tags
}
