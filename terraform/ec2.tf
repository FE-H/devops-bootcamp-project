data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_iam_instance_profile" "ctr-profile" {
  name = "ansible-control-node"
}

data "aws_iam_instance_profile" "web-profile" {
  name = "web-ecr"
}

data "aws_iam_instance_profile" "mon-profile" {
  name = "monitoring"
}

data "aws_ssm_parameter" "token" {
  name = "/devops-bootcamp-2026/tunnel-token"
}

module "pub-web" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name                   = "tf-server-public"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.public_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.pub_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.web-profile.name

  tags = { Name = "tf-web-server-public" }
}

module "pri-ctr" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name                   = "tf-ctr-server-private"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.private_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.pri_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.ctr-profile.name

  tags = { Name = "tf-ctrl-server-private" }
}

module "pri-mon" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name                   = "tf-mon-server-private"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.private_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.pri_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.mon-profile.name

  tags = { Name = "tf-mon-server-private" }
}

resource "cloudflare_dns_record" "cf_rec" {
  zone_id = var.cloudflare_zone_id
  name = var.cloudflare_record
  content = module.pub-web.public_ip
  type = "A"
  ttl = 1
} 