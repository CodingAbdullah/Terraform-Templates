provider "aws" {
  region = var.region
}

module "vpc" {
  source             = "./modules/vpc"
  subnet_cidr        = var.subnet_cidr
  availability_zone  = var.availability_zone
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source                 = "./modules/ec2"
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = [module.security_group.security_group_id]
  instance_type          = var.instance_type
  ami_id                 = var.ami_id
}