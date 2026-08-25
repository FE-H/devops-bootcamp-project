module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "tf-vpc"
  cidr = "10.0.0.0/24"
  azs  = ["ap-southeast-1"]

  public_subnets  = ["10.0.0.0/24"]
  private_subnets = ["10.0.1.0/24"]

  map_public_ip_on_launch = true
  enable_nat_gateway      = true
  single_nat_gateway      = true
}