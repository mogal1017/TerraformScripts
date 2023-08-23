provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "web_sub_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "web_subnet1"
  }
}

resource "aws_subnet" "web_sub_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "web_subnet2"
  }
}

resource "aws_subnet" "app_sub_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "app_subnet1"
  }
}

resource "aws_subnet" "app_sub_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "app_subnet2"
  }
}

resource "aws_subnet" "db_sub_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "db_subnet1"
  }
}

resource "aws_subnet" "db_sub_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "db_subnet2"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "sg for web tier"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "sg for app tier"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "sg for db tier"
  vpc_id      = aws_vpc.my_vpc.id
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "mydb-subnet-group"
  subnet_ids = [aws_subnet.db_sub_1.id, aws_subnet.db_sub_2.id]
}

resource "aws_db_instance" "db_group" {
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  identifier          = "mydb"
  username            = "admin"
  password            = "mysecretpassword"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

# Outputs

output "db_endpoint" {
  value = aws_db_instance.db_group.endpoint
}

