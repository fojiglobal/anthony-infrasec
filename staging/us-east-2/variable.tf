variable "staging_vpc_cidr" {
    type = string
    default = "10.30.0.0/16"
}

variable "qa_vpc_cidr" {
    type = string
    default = "10.30.0.0/16"
}

variable "disable_sub" {
  type = bool
  default = false
  }