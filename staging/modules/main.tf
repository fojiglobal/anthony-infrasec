locals {
  vpc_cidr = "10.120.0.0/16"
  env = "dev"
}

module "dev" {
    source = "./module/"
    vpc_cidr = local.vpc_cidr   
    env = "dev"
}