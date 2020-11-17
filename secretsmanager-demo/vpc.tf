# Document URL : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true 
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-${var.vpc_name}"
  }
}
