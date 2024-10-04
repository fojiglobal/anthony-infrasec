#################### Locals for VPC ####################
locals {
  vpc_cidr = "10.50.0.0/16"
  env = "staging"
}

locals {
  qa_cidr = "10.60.0.0/16"
  qa_env = "qa"
}