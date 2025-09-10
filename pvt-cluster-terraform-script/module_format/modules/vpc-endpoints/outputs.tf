output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}

output "interface_endpoints" {
  value = [for ep in aws_vpc_endpoint.interface : ep.id]
}
