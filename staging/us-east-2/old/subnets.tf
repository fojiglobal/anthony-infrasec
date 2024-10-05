######################## Public Subnets ###################
resource "aws_subnet" "staging_pub_1" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "10.30.10.0/24"
  availability_zone       = var.use2a
  map_public_ip_on_launch = true
  tags = {
    Name = "staging-pub-1"
  }
}

resource "aws_subnet" "staging_pub_2" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "10.30.20.0/24"
  availability_zone       = var.use2b
  map_public_ip_on_launch = true
  tags = {
    Name = "staging-pub-2"
  }
}

######################## Private Subnets ###################
resource "aws_subnet" "staging_pri_1" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "10.30.30.0/24"
  availability_zone       = var.use2a
  map_public_ip_on_launch = true
  tags = {
    Name = "staging-pri-1"
  }
}

resource "aws_subnet" "staging_pri_2" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "10.30.40.0/24"
  availability_zone       = var.use2b
  map_public_ip_on_launch = true
  tags = {
    Name = "staging-pri-2"
  }
}