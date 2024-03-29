terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source                   = "../../modules/vpc"
  availability_zones_count = 2
  availability_zones_count_private = 3
  subnet_cidr_bits         = 8
  project                  = "Akzhol"
  tagname_env = "stage"

}

module "eks" {
  source         = "../../modules/eks"
  project        = "stage-eks"
  vpc_id         = module.vpc.vpc_id
  public_subnet = module.vpc.public_subnet_id
  

}

module "instance" {
  source         = "../../modules/instance"
  public_subnets = module.vpc.public_subnet_id
  vpc_id         = module.vpc.vpc_id

}
