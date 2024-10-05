#################### Locals for VPC ####################
locals {
  vpc_cidr = "10.50.0.0/16"
  env      = "staging"
}

#################### Public Subnet Locals ####################

locals {
  public_subnets = {
    "pub-sub-1" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 1)
      azs  = "us-east-2a"
      tags = {
        Name        = "pub-sub-1"
        Environment = "local.env"
      }
    }
    "pub-sub-2" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 2)
      azs  = "us-east-2b"
      tags = {
        Name        = "pub-sub-2"
        Environment = "local.env"
      }
    }
    "pub-sub-1" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 3)
      azs  = "us-east-2c"
      tags = {
        Name        = "pub-sub-3"
        Environment = "local.env"
      }
    }
  }
}

#################### Private Subnet Locals ####################

locals {
  private_subnets = {
    "pri-sub-1" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 10)
      azs  = "us-east-2a"
      tags = {
        Name        = "pri-sub-1"
        Environment = "local.env"
      }
    }
    "pri-sub-2" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 11)
      azs  = "us-east-2b"
      tags = {
        Name        = "pri-sub-2"
        Environment = "local.env"
      }
    }
    "pri-sub-1" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 12)
      azs  = "us-east-2c"
      tags = {
        Name        = "pri-sub-3"
        Environment = "local.env"
      }
    }
  }
}

#################### Locals Public SG ####################
locals {
  public-sg-ingress = {
    "all-http" = {
      src         = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "Allow HTTP From Anywhere"
    }
    "all-https" = {
      src         = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "Allow HTTPS From Anywhere"
    }
  }
  public-sg-egress = {
    "all-http" = {
      dest        = "0.0.0.0/0"
      ip_protocol = "-1"
      description = "Allow All To Anywhere"
    }
  }
}


#################### Locals Private SG ####################
locals {
  private-sg-egress = {
    "all" = {
      dest        = "0.0.0.0/0"
      ip_protocol = "-1"
      description = "Allow All To Anywhere"
    }
  }
  private-sg-ingress = {

    "alb-http" = {
      src         = module.staging.public_sg_id
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "Allow HTTP From Anywhere"
    }

    "alb-https" = {
      src         = module.staging.public_sg_id
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "Allow HTTPS From Anywhere"
    }

    "bastion-ssh" = {
      src = module.staging.public_sg_id
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      description = "Allow SSH From Bastion"
    }
  }
}

#################### Bastion SG Rules ####################

locals {
  bastion-sg-egress = {
    "all" = {
      dest        = "0.0.0.0/0"
      ip_protocol = "-1"
      description = "Allow All To Anywhere"
    }
  }

  bastion-sg-ingress = {
    "all-ssh" = {
      src         = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      description = "Allow SSH From Anywhere"
    }
  }
}
  