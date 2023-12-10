provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "dmitry-eks"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.20.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "dmitry-node-group"

      instance_types = ["t2.small"]
      
      capacity_type ="ON_DEMAND"
      update_config = {
        max_unavailable_percentage = 50
      }
      
      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "s3-aws-tf-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "s3-tf-state-db"
    encrypt        = true
  }
}

