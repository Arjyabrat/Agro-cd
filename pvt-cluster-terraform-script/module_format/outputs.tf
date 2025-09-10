output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "public_rt_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}

output "private_rt_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}
