variable "vpc_cidr" {
  type = string
}

variable "env" {
    type = string
}
  
  #################### Subnet Variables ####################
  variable "public_subnets" {
    type = map(object({
      cidr = string
      azs = string
      tags = map(string) 
    }))
}