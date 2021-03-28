module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "single-container-vpc"
  cidr = var.vpc_cidr

   azs             = [ "ap-southeast-2a" ]
  # private_subnets = [var.private_subnet]
   public_subnets  = [ var.public_subnet ]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  #   tags = {
  #     Terraform = "true"
  #     Environment = "dev"
  #  }
}

resource "aws_security_group" "fargate_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}