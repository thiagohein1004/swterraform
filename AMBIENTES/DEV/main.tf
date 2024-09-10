# main.tf

module "network" {
  source  = "./modules/network"
  vpc_cidr = "10.20.0.0/23"
  vpc_name = "vpc-splitwave-dev"
}

