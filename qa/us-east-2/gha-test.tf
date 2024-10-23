resource "aws_vpc" "qa" {
  cidr_block = "10.11.0.0/16"
  tags = {
    Name        = "qa_vpc"
    Environment = "qa"
  }
}