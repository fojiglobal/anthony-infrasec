variable "enable_dns" {
  type    = bool
  default = false
}

variable "public_subnets" {
  type = map(object({
    cidr             = string
    tags             = map(string)
    azs              = string
    enable_public_ip = bool
  }))
}

  variable "private_subnets" {
  type = map(object({
    cidr             = string
    tags             = map(string)
    azs              = string
  }))
}

variable "env" {
  type = string
}

variable "vpc_cidr" {
  type = string
}