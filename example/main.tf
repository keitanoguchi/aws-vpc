module "main" {
  source = "../"

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
