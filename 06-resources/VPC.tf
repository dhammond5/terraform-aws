locals {
  commonly_used_tags = {
    Project   = "06-resources"
    ManagedBy = "Terraform"
    Env       = "Test"
  }
}

resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-main_vpc"
  })

}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-public_subnet"
  })
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "10.0.1.0/24"

  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-private_subnet"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-main_igw"
  })
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }

  tags = merge(local.commonly_used_tags, {
    Name = "06-resources-main_route_table"
  })
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}