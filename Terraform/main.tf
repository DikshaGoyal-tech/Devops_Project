terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}
 
provider "aws" {
  region = var.region
}
 
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = ">= 19.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = var.private_subnets
  vpc_id          = var.vpc_id
 
  node_groups = {
    managed_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      additional_tags = { "k8s-worker" = "true" }
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
    }
  }
}
 
# OIDC provider and IRSA roles are created by module outputs — you may reference them
 
resource "aws_iam_policy" "external_secrets_read" {
  name   = "external-secrets-read"
  policy = file("./policies/external-secrets-read.json")
}
