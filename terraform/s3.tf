module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "bootcamp-2026-proj-ssm"

  force_destroy = true
}