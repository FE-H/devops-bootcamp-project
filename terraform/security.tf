#TODO : check how to create security group for public and private. {public : [0.0.0.0/0, 80:80], [10.0.1.0/24, 9100:9100], [10.0.0.0/16, 22:22]; private : [10.0.0.0/16, 22:22]}
module "pub_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "devops-public-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id

  ingress_rules = {
    http = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
    }

    ssh = {
      cidr_ipv4   = "10.0.0.0/16"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    }

    prometheus = {
      cidr_ipv4   = "10.0.1.0/24"
      ip_protocol = "tcp"
      from_port   = 9090
      to_port     = 9090
    }

    node_exporter = {
      cidr_ipv4   = "10.0.1.0/24"
      ip_protocol = "tcp"
      from_port   = 9100
      to_port     = 9100
    }
  }

  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1" }
  }

  tags = { NAME = "devops-public-sg" }
}

module "pri_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "devops-private-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id

  ingress_rules = {
    ssh = {
      cidr_ipv4   = "10.0.0.0/16"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    }
  }

  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1" }
  }

  tags = { NAME = "devops-private-sg" }
}