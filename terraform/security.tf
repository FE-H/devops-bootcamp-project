#TODO : check how to create security group for public and private. {public : [0.0.0.0/0, 80:80], [10.0.1.0/24, 9100:9100], [10.0.0.0/16, 22:22]; private : [10.0.0.0/16, 22:22]}
module "my_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "devops-vpc-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id

  ingress_rules = {
    http = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
    }
  }

  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1" }
  }

  tags = { NAME = "devops-vpc-sg" }
}