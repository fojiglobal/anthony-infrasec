# Create a VPC
resource "aws_vpc" "staging" {
  cidr_block = var.staging_vpc_cidr
  tags = {
    name = "staging"
    environment = "staging now"
  }
}

resource "aws_vpc" "qa" {
  cidr_block = var.qa_vpc_cidr
  tags = {
    name = "qa"
    environment = "staging now"
  }
}