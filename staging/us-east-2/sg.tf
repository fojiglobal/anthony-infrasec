######################### Public Security Group #######################
resource "aws_security_group" "pub_sg" {
  # ... other configuration ...
  name   = "public-sg"
  description = "Security group for public instances"
  vpc_id = aws_vpc.staging.id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "public-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

######################### Public Security Group #######################
#
#
######################### Bastion Security Group #######################
resource "aws_security_group" "bastion_sg" {
  name   = "bastion-sg"
  description = "Security group for bastion instances"
  vpc_id = aws_vpc.staging.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "bastion-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

###################### Bastion Security Group ##########################
#
#
######################### private Security Group #######################
resource "aws_security_group" "private_sg" {
  name   = "private-sg"
  description = "Security group for private instances"
  vpc_id = aws_vpc.staging.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.pub_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.pub_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "private-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}

###################### private Security Group #######################