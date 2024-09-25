
# ######################################################
# # This command will allow you to specifically allow you
# # to grab the id of the subnet
# ######################################################
# output "pub_sub1" {
#   value = aws_subnet.public_subnets["pub-sub1"].id
# }
# ######################################################
# # This command references a specific VPC resource with
# # the key "staging". It outputs the id of the VPC 
# # resource named "staging". This is useful when you have 
# # multiple VPCs defined and you want to output the ID 
# # of a particular VPC identified by the key "staging"
# ######################################################
# output "staging_vpc" {
#   value = aws_vpc.vpcs["staging"].id
# }