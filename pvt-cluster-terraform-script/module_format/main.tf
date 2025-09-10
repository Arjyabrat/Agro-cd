module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidrs = var.public_subnets_cidrs
  private_subnets_cidrs= var.private_subnets_cidrs
  availability_zones   = var.availability_zones
  cluster_name         = var.cluster_name
}

module "security_groups" {
  source       = "./modules/security-groups"
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
  cluster_name = var.cluster_name
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
}

module "vpc_endpoints" {
  source       = "./modules/vpc-endpoints"
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  public_route_table = module.vpc.public_rt_id
  private_route_table= module.vpc.private_rt_id
  vpc_cidr     = var.vpc_cidr
  cluster_name = var.cluster_name
  aws_region   = var.aws_region
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id       = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  node_role_arn   = module.iam.node_role_arn
  cluster_role_arn= module.iam.cluster_role_arn
  node_group_instance_types = var.node_group_instance_types
  node_group_desired = var.node_group_desired
  node_group_min     = var.node_group_min
  node_group_max     = var.node_group_max
  aws_region         = var.aws_region
}
