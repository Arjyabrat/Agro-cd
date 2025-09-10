variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "public_route_table" { type = string }
variable "private_route_table" { type = string }
variable "vpc_cidr" { type = string }
variable "cluster_name" { type = string }
variable "aws_region" { type = string }
