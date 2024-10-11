#################### Locals for VPC ####################
locals {
  # CIDR block for the VPC
  vpc_cidr = "10.50.0.0/16"
  # Environment name
  env      = "staging"
}

#################### Public Subnet Locals ####################

locals {
  public_subnets = {
    "pub-sub-1" = {
      # CIDR block for the public subnet 1
      cidr = cidrsubnet(local.vpc_cidr, 8, 1)
      # Availability Zone for the public subnet 1
      azs  = "us-east-2a"
      tags = {
        Name        = "pub-sub-1"
        Environment = "local.env"
      }
    }
    "pub-sub-2" = {
      # CIDR block for the public subnet 2
      cidr = cidrsubnet(local.vpc_cidr, 8, 2)
      # Availability Zone for the public subnet 2
      azs  = "us-east-2b"
      tags = {
        Name        = "pub-sub-2"
        Environment = "local.env"
      }
    }
    "pub-sub-3" = {
      # CIDR block for the public subnet 3
      cidr = cidrsubnet(local.vpc_cidr, 8, 3)
      # Availability Zone for the public subnet 3
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
      # CIDR block for the private subnet 1
      cidr = cidrsubnet(local.vpc_cidr, 8, 10)
      # Availability Zone for the private subnet 1
      azs  = "us-east-2a"
      tags = {
        Name        = "pri-sub-1"
        Environment = "local.env"
      }
    }
    "pri-sub-2" = {
      # CIDR block for the private subnet 2
      cidr = cidrsubnet(local.vpc_cidr, 8, 11)
      # Availability Zone for the private subnet 2
      azs  = "us-east-2b"
      tags = {
        Name        = "pri-sub-2"
        Environment = "local.env"
      }
    }
    "pri-sub-3" = {
      # CIDR block for the private subnet 3
      cidr = cidrsubnet(local.vpc_cidr, 8, 12)
      # Availability Zone for the private subnet 3
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
      # Allow HTTP traffic from anywhere
      src         = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "Allow HTTP From Anywhere"
    }
    "all-https" = {
      # Allow HTTPS traffic from anywhere
      src         = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "Allow HTTPS From Anywhere"
    }
  }
  public-sg-egress = {
    "all-http" = {
      # Allow all outbound traffic to anywhere
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
      # Allow all outbound traffic to anywhere
      dest        = "0.0.0.0/0"
      ip_protocol = "-1"
      description = "Allow All To Anywhere"
    }
  }
  private-sg-ingress = {
    "alb-http" = {
      # Allow HTTP traffic from the ALB
      src         = module.staging.public_sg_id
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "Allow HTTP From Anywhere"
    }
    "alb-https" = {
      # Allow HTTPS traffic from the ALB
      src         = module.staging.public_sg_id
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "Allow HTTPS From Anywhere"
    }
    "bastion-ssh" = {
      # Allow SSH traffic from the Bastion host
      src         = module.staging.public_sg_id
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
      # Allow all outbound traffic to anywhere
      dest        = "0.0.0.0/0"
      ip_protocol = "-1"
      description = "Allow All To Anywhere"
    }
  }
  bastion-sg-ingress = {
    "all-ssh" = {
      # Allow SSH traffic from anywhere
      src         = "0.0.0.0/0"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      description = "Allow SSH From Anywhere"
    }
  }
}

#################### ALB ####################
locals {
  # ALB SSL profile
  alb_sss_profile = "ELBSecurityPolicy-2016-08"
  # ALB HTTPS port
  alb_port_https  = 443
  # ALB HTTPS protocol
  alb_proto_https = "HTTPS"
  # ALB HTTP port
  alb_port_http   = 80
  # ALB HTTP protocol
  alb_proto_http  = "HTTP"
}

#################### ALB ####################
locals {
  # Map public IP to instances
  map_public_ip = true
  # Minimum number of instances
  min_size      = 1
  # CIDR block for all IPv4 addresses
  all_ipv4_cidr = "0.0.0.0/0"
  # Maximum number of instances
  max_size      = 3
  # Instance type
  instance_type = "t2.micro"
  # Key pair name
  instance_key  = "dso-us-east-2-base"
  # AMI ID
  ami_id        = "ami-0c55b159cbfafe1f0"
  # User data script
  user_data     = filebase64("web.sh")
  # Desired number of instances
  desired       = 2

  # Route 53 zone ID
  zone_id         = data.aws_route53_zone.segantlabs.id
  # ACM certificate ARN
  certificate_arn = data.aws_acm_certificate.alb_cert.arn
}