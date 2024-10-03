locals {
  vpc_cidr = "10.120.0.0/16"
  env = "dev"
  public_subnets = {
    "pub-sub1" = {
      cidr             = "10.120.1.0/24"
      azs              = "us-east-2a"
      enable_public_ip = true
      tags = {
        name        = "pub-sub1"
        environment = "dev"
      }
    }
    "pub-sub2" = {
      cidr             = "10.120.2.0/24"
      azs              = "us-east-2b"
      enable_public_ip = true
      tags = {
        name        = "pub-sub2"
        environment = "dev"
      }
    }
    "pub-sub3" = {
      cidr             = "10.120.3.0/24"
      azs              = "us-east-2c"
      enable_public_ip = true
      tags = {
        name        = "pub-sub3"
        environment = "dev"
      }
    }
  }
  private_subnets = {
    "pri-sub1" = {
      cidr             = "10.120.10.0/24"
      azs              = "us-east-2a"
      tags = {
        name        = "pri-sub1"
        environment = "dev"
      }
    }
    "pri-sub2" = {
      cidr             = "10.120.11.0/24"
      azs              = "us-east-2b"
      tags = {
        name        = "pri-sub2"
        environment = "dev"
      }
    }
    "pri-sub3" = {
      cidr             = "10.120.12.0/24"
      azs              = "us-east-2c"
      tags = {
        name        = "pri-sub3"
        environment = "dev"
      }
    }
  }
}

module "dev" {
    source = "./module/"
    vpc_cidr = local.vpc_cidr
    env = "local.env"
    public_subnets = local.public_subnets
    private_subnets = local.private_subnets
}