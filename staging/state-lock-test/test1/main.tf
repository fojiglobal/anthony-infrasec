# Create a VPC
resource "aws_vpc" "staging" {
  cidr_block = "10.50.0.0/16"
  tags = {
    name        = "staging-vpc"
    environment = "staging"
  }
}
