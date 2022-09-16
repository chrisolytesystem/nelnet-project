# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4" 
  # version = "~> 3.14"


  # VPC Basic Details
  name = "vpc-dev" 
  cidr = "10.10.0.0/22"  
  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets      = ["10.10.101.0/24", "10.10.102.0/24"]

  # Lambda Subnets
  create_Lambda_subnet_group = true
  create_lambda_subnet_route_table= true
  lambda_subnets    = ["10.10.151.0/24", "10.10.152.0/24"]

  #create_lambda_nat_gateway_route = true
  #create_lambda_internet_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  lambda_subnet_tags = {
    Type = "lambda-subnets"
  }

  tags = {
    Owner = "nelnetbank"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}
