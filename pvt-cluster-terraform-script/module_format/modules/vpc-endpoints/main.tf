resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.public_route_table, var.private_route_table]
  tags              = { Name = "${var.cluster_name}-s3-endpoint" }
}

locals {
  interface_endpoints = ["ecr.api", "ecr.dkr", "sts", "logs", "ec2"]
}

resource "aws_security_group" "endpoints_sg" {
  name        = "${var.cluster_name}-endpoints-sg"
  description = "SG for interface endpoints"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "interface" {
  for_each            = toset(local.interface_endpoints)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.${each.key}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  security_group_ids  = [aws_security_group.endpoints_sg.id]
  private_dns_enabled = true
  tags                = { Name = "${var.cluster_name}-${each.key}-endpoint" }
}
