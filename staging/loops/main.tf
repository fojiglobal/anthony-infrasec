# resource "aws_vpc" "main" {
#   count                = var.vpc_count
#   cidr_block           = var.cidr_block
#   enable_dns_hostnames = var.enable_dns
# }

# ################################################
# This will iterate through the the variable called 
# infrasec_users to create iam users through the name
# defined in the list
# ################################################

# resource "aws_iam_user" "name" {
#   count = length(var.infrasec_users)
#   name  = var.infrasec_users[count.index]
# }

# ################################################
# This assigns the value of the output variable. It 
# retrieves the name attribute of the first element
# in the aws_iam_user.name resource. In essence, 
# this code outputs the name of the first AWS IAM 
# user defined in your Terraform configuration under
# the aws_iam_user.name resource.
# ################################################

# output "jdoe" {
#   value = aws_iam_user.name[0].name
# }

# ################################################
# It retrieves the name attribute of all elements
# in the aws_iam_user.name resource. In essence,
# this code will output a list of names for all 
# AWS IAM users defined in your Terraform 
# configuration under the aws_iam_user.name resource1.
# ################################################

# output "user_arn" {
#   value = aws_iam_user.name[*].name
# }

# resource "aws_iam_user" "managers" {
#   for_each = toset(var.managers)
#   name     = each.value
# }


#################################################
# This Terraform configuration dynamically creates 
# multiple VPCs based on the values defined in the
# var.vpcs variable, setting their CIDR blocks, 
# tags, and DNS hostname settings accordingly.
#################################################
resource "aws_vpc" "vpcs" {
  for_each             = var.vpcs
  cidr_block           = each.value["cidr"]
  tags                 = each.value["tags"]
  enable_dns_hostnames = each.value["enable_dns"]
}

#################################################
# This code dynamically creates two AWS VPCs with
# the CIDR blocks 10.80.0.0/16 and 10.90.0.0/16. 
# The for_each loop iterates over the list of CIDR
# blocks defined in the test_vpc variable, creating 
# a VPC for each block.
#################################################

# resource "aws_vpc" "dr_vpc" {
#   for_each = toset(var.test_vpc)
#   cidr_block = each.value  
# }

resource "aws_vpc" "dr" {
  cidr_block = "10.110.0.0/16"
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.dr.id
  for_each = var.public_subnets
  cidr_block = each.value["cidr"]
  availability_zone = each.value["azs"]
  map_public_ip_on_launch = each.value["enable_public_ip"]
  tags = each.value["tags"]
}

######################################################
# This command will allow you to specifically allow you
# to grab the id of the subnet
######################################################

output "pub_sub1" {
  value = aws_subnet.public_subnets["pub-sub1"].id
}

######################################################
# This command will allow you to specifically allow you
# to grab the id of the VPC. The wildcard outputs all VPC
# information
######################################################

# output "staging_vpc" {
#   value = aws_vpc.vpcs[*]
# }

######################################################
# This command references a specific VPC resource with
# the key "staging". It outputs the id of the VPC 
# resource named "staging". This is useful when you have 
# multiple VPCs defined and you want to output the ID 
# of a particular VPC identified by the key "staging"
######################################################

output "staging_vpc" {
  value = aws_vpc.vpcs["staging"].id
}