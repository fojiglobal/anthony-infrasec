variable "cidr_block" {
  type    = string
  default = "10.50.0.o/16"
}

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
    enable_public_ip = bool

  }))
}

variable "env" {
  type = string
}

variable "vpc_cidr" {
  type = string
}