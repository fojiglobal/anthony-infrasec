module "staging" {
  source = "./modules"
  vpc_cidr = local.vpc_cidr
  env = local.env
}

module "qa" {
  source = "./modules"
  vpc_cidr = local.qa_cidr
  env = local.qa_env
}