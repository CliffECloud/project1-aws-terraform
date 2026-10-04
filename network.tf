resource "aws_vpc" "project1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-ha-web-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.project_name}-ha-web-subnet-public1-us-east-1a"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.project_name}-ha-web-subnet-public2-us-east-1b"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.project_name}-ha-web-subnet-private1-us-east-1a"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.project_name}-ha-web-subnet-private2-us-east-1b"
  }
}

resource "aws_internet_gateway" "project1" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "${var.project_name}-ha-web-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "${var.project_name}-ha-web-rtb-public"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.project1.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "${var.project_name}-ha-web-rtb-private1-us-east-1a"
  }
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "${var.project_name}-ha-web-rtb-private2-us-east-1b"
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

