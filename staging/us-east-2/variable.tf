variable "staging_vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "qa_vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "disable_sub" {
  type    = bool
  default = false
}

variable "use2a" {
  type    = string
  default = "us-east-2a"
}

variable "use2b" {
  type    = string
  default = "us-east-2b"
}

variable "staging_env" {
  type    = string
  default = "staging"
}