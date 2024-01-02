output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnet.id
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet.id
}
output "private_subnets_2" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnet_2.id
}