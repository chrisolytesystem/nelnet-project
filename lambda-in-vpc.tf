module "lambda_function_in_vpc" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "my-lambda-in-vpc"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "../fixtures/python3.8-app1"

  vpc_subnet_ids         = module.vpc.intra_subnets
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  attach_network_policy = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.10.0.0/22"

  # Specify at least one of: intra_subnets, private_subnets, or public_subnets
  azs           = ["us-east-1a", "us-east-1b"]
  intra_subnets = ["10.10.101.0/24", "10.10.102.0/24"]
}