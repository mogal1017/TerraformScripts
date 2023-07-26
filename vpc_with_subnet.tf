# Provider configuration
provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Three_tier_vpc"
  }
}

# Create public subnet1
resource "aws_subnet" "my_public_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "public_subnet1"
  }
}

# Create public subnet2
resource "aws_subnet" "my_public_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_subnet2"
  }
}

# Create private subnet1
resource "aws_subnet" "my_private_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private_subnet1"
  }
}

# Create private subnet2
resource "aws_subnet" "my_private_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "private_subnet2"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "this is three-tier archi ig"
  }
}

# Create NAT gateway for the first public subnet
resource "aws_nat_gateway" "my_nat1" {
  allocation_id = aws_eip.my_eip1.id
  subnet_id     = aws_subnet.my_public_subnet1.id

  tags = {
    Name = "Nat gateway for pub subnet 1"
  }
}

# Create Elastic IP for the first NAT gateway
resource "aws_eip" "my_eip1" {
  vpc = true
}

# Create NAT gateway for the second public subnet
resource "aws_nat_gateway" "my_nat2" {
  allocation_id = aws_eip.my_eip2.id
  subnet_id     = aws_subnet.my_public_subnet2.id

  tags = {
    Name = "Nat gateway for another public subnet2"
  }
}

# Create Elastic IP for the second NAT gateway
resource "aws_eip" "my_eip2" {
  vpc = true
}
