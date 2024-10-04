resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
        Environment = var.env
    }
}