# Output the ID of the VPC
output "vpc_id" {
  value = aws_vpc.vpc.id  
}

# Output the IDs of the public subnets
output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id ]
}

# Output the IDs of the private subnets
output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id ]
}

# Output the ID of the private security group
output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

# Output the ID of the public security group (Note: This seems to be a mistake, should it be aws_security_group.public_sg.id?)
output "public_sg_id" {
  value = aws_security_group.private_sg.id
}

# Output the ID of the bastion security group
output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}