variable "staging_vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "qa_vpc_cidr" {
  type    = string
  default = "10.40.0.0/16"
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

variable "alb_port_http" {
  type    = string
  default = "80"
}

variable "alb_port_https" {
  type    = string
  default = "443"
}

variable "alb_proto_http" {
  type    = string
  default = "HTTP"
}

variable "alb_proto_https" {
  type    = string
  default = "HTTPS"
}

variable "alb_sss_profile" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}