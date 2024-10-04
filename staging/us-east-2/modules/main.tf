resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
        Environment = var.env
    }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  for_each = var.public_subnets 
  cidr_block = each.value ["cidr"]
  availability_zone = each.value["azs"]
  tags = each.value["tags"]
}