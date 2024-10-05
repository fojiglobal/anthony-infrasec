module "staging" {
  source             = "./modules"
  vpc_cidr           = local.vpc_cidr
  env                = local.env
  public_subnets     = local.public_subnets
  private_subnets    = local.private_subnets
  pub-sub-name       = "pub-sub-1"
  user_data          = filebase64("web.sh")
  public_sg_egress   = local.public-sg-egress
  public_sg_ingress  = local.public-sg-ingress
  private_sg_egress  = local.private-sg-egress
  private_sg_ingress = local.private-sg-ingress
  bastion_sg_ingress = local.bastion-sg-ingress
  bastion_sg_egress  = local.bastion-sg-egress
}

output "vpc_id" {
  value = module.staging.vpc_id
}

output "pub_subnet_id" {
  value = module.staging.public_subnet_ids
}
