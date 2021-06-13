provider "aws" {
  region = "ap-northeast-1"
}

module "main" {
  source = "../"

  vpc_name                   = local.vpc_name
  vpc_cidr_block             = local.vpc_cidr_block
  create_public_subnet       = local.create_public_subnet
  public_subnet_cidr_blocks  = local.public_subnet_cidr_blocks
  create_private_subnet      = local.create_private_subnet
  private_subnet_cidr_blocks = local.private_subnet_cidr_blocks
  azs                        = local.azs
  tags                       = local.tags
}

locals {
  vpc_name             = "main"
  vpc_cidr_block       = "10.0.0.0/16"
  create_public_subnet = true
  public_subnet_cidr_blocks = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
  create_private_subnet = true
  private_subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
  azs = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
  tags = {
    ManagedBy = "Terraform"
  }
}
