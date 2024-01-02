# Provider configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Create an EKS cluster
resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.my_eks_cluster_role.arn
  version  = var.cluster_version

  vpc_config {
    endpoint_private_access   = var.endpoint_private_access
    endpoint_public_access    = var.endpoint_public_access
    subnet_ids                = var.subnet_ids
  }

  tags = var.tags
  depends_on = [
    aws_iam_role_policy_attachment.my_eks_cluster_policy_attachment,
    aws_iam_role.my_eks_cluster_role
  ]
}



# Create an IAM role for the EKS cluster
resource "aws_iam_role" "my_eks_cluster_role" {
  name = "my-eks-cluster-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach necessary policies to the IAM role
resource "aws_iam_role_policy_attachment" "my_eks_cluster_policy_attachment" {
  role       = aws_iam_role.my_eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}




resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.this.arn
  subnet_ids      = var.subnet_ids
  instance_types  = [var.node_instance_type]

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.eks, 
    aws_iam_role.this,
    aws_iam_role_policy_attachment.this-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.this-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.this-AmazonEC2ContainerRegistryReadOnly
  ]
}
resource "aws_iam_role" "this" {
  name = "eks-node-group-this"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "this-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "this-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "this-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.this.name
}


