variable "vpc_count" {
  type    = number
  default = 2
}

variable "cidr_block" {
  type    = string
  default = "10.50.0.o/16"
}

variable "enable_dns" {
  type    = bool
  default = false
}

#################################################
# Variable list of users
#################################################
variable "infrasec_users" {
  type    = list(string)
  default = ["jdoe", "jdone", "jbrown"]
}

#################################################
# Variable list of managers
#################################################
variable "managers" {
  type    = list(string)
  default = ["bobama", "jbiden", "kharris"]
}

######################################################
# Defined variable using for each loop to create VPC's
######################################################

variable "vpcs" {
  type = map(object({
    cidr       = string
    tags       = map(string)
    tenacy     = string
    enable_dns = bool
  }))
  default = {
    "staging" = {
      cidr       = "10.50.0.0/16"
      tenacy     = "default"
      enable_dns = false
      tags = {
        name        = "staging_vpc"
        environment = "staging"
      }
    }

    "qa" = {
      cidr       = "10.60.0.0/16"
      tenacy     = "default"
      enable_dns = false
      tags = {
        name        = "qa_vpc"
        environment = "qa"
      }
    }

    "prod" = {
      cidr       = "10.70.0.0/16"
      tenacy     = "default"
      enable_dns = false
      tags = {
        name        = "prod_vpc"
        environment = "prod"
      }
    }
  }
}
variable "test_vpc" {
  type    = list(string)
  default = ["10.80.0.0/16", "10.90.0.0/16"]
}

######################################################
# Declare variable for creating multiple subnets. This 
# defines the structure of the subnets
######################################################

variable "public_subnets" {
  type = map(object({
    cidr             = string
    tags             = map(string)
    azs              = string
    enable_public_ip = bool

  }))
  default = {
    "pub-sub1" = {
      cidr             = "10.110.1.0/24"
      azs              = "us-east-2a"
      enable_public_ip = true
      tags = {
        name        = "pub-sub1"
        environment = "staging"
      }
    }

    "pub-sub2" = {
      cidr             = "10.110.2.0/24"
      azs              = "us-east-2b"
      enable_public_ip = true
      tags = {
        name        = "pub-sub2"
        environment = "staging"
      }
    }

    "pub-sub3" = {
      cidr             = "10.110.3.0/24"
      azs              = "us-east-2c"
      enable_public_ip = true
      tags = {
        name        = "pub-sub3"
        environment = "staging"
      }
    }
  }
}