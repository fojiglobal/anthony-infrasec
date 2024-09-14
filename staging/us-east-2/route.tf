resource "aws_route_table" "pub_rtr" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging.id
  }

  tags = {
    Name = "public-rtr"
  }

  resource "aws_route_table_association" "pub_sub_1" {
    subnet_id      = aws_subnet.staging_pub_1.id
    route_table_id = aws_route_table.pub_rtr.id
  }

  resource "aws_route_table_association" "pub_sub_2" {
    subnet_id      = aws_subnet.staging_pub_2.id
    route_table_id = aws_route_table.pub_rtr.id
  }
}