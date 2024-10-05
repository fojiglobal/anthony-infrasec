output "vpc_id" {
    value = aws_vpc.this.id  
}

output "public_subnet_ids" {
    value = [for subnet in aws_subnet.public : subnet.id ]
}

output "private_subnet_ids" {
    value = [for subnet in aws_subnet.private : subnet.id ]
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

output "public_sg_id" {
  value = aws_security_group.private_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}