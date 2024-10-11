# Define the staging module with various configurations
module "staging" {
  source             = "./modules"                # Path to the module source
  vpc_cidr           = local.vpc_cidr             # VPC CIDR block
  env                = local.env                  # Environment name
  public_subnets     = local.public_subnets       # List of public subnets
  private_subnets    = local.private_subnets      # List of private subnets
  pub-sub-name       = "pub-sub-1"                # Name for the public subnet
  user_data          = local.user_data            # User data script for instances
  public_sg_egress   = local.public-sg-egress     # Security group egress rules for public subnets
  public_sg_ingress  = local.public-sg-ingress    # Security group ingress rules for public subnets
  private_sg_egress  = local.private-sg-egress    # Security group egress rules for private subnets
  private_sg_ingress = local.private-sg-ingress   # Security group ingress rules for private subnets
  bastion_sg_ingress = local.bastion-sg-ingress   # Security group ingress rules for bastion host
  bastion_sg_egress  = local.bastion-sg-egress    # Security group egress rules for bastion host
  alb_sss_profile    = local.alb_sss_profile      # ALB SSS profile
  alb_port_https     = local.alb_port_https       # ALB HTTPS port
  alb_proto_https    = local.alb_proto_https      # ALB HTTPS protocol
  alb_port_http      = local.alb_port_http        # ALB HTTP port
  alb_proto_http     = local.alb_proto_http       # ALB HTTP protocol
  map_public_ip      = local.map_public_ip        # Map public IPs to instances
  min_size           = local.min_size             # Minimum size of the auto-scaling group
  max_size           = local.max_size             # Maximum size of the auto-scaling group
  instance_type      = local.instance_type        # EC2 instance type
  instance_key       = local.instance_key         # SSH key for instances
  ami_id             = local.ami_id               # AMI ID for instances
  desired            = local.desired              # Desired number of instances
  all_ipv4_cidr      = local.all_ipv4_cidr        # IPv4 CIDR block for all IPs
  zone_id            = local.zone_id              # Route53 zone ID
  certificate_arn    = local.certificate_arn      # ARN of the SSL certificate
}

# Output the VPC ID
output "vpc_id" {
  value = module.staging.vpc_id
}

# Output the public subnet IDs
output "pub_subnet_id" {
  value = module.staging.public_subnet_ids
}
