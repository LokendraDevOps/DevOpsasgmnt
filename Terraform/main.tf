provider "aws"{
  region  = "us-east-1"
 }
resource "aws_instance" "master" {
  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = "source_key"
  user_data              = file("install.sh")

  tags = {
    Name = "Master"
  }
}
resource "aws_instance" "Slave-1" {
  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-local-subnet-1.id
  vpc_security_group_ids = [aws_security_group.Privet-security-group.id]
  key_name               = "source_key"
  user_data              = file("install_java.sh")

  tags = {
    Name = "Slave-1"
  }
}
resource "aws_instance" "Slave-2" {
  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-local-subnet-1.id
  vpc_security_group_ids = [aws_security_group.Privet-security-group.id]
  key_name               = "source_key"
  user_data              = file("install_java.sh")
  tags = {
    Name = "Slave-2"
  }
}
resource "aws_security_group" "webserver-security-group"{
  name        = "webserver-security-group"
  description = "Enable All traffic"
  vpc_id      = aws_vpc.vpc_01.id
    ingress {
    description     = "All Traffic"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Web server Security group"
  }
}

resource "aws_security_group" "Privet-security-group"{
  name        = "Privet-security-group"
  description = "Disable All traffic"
  vpc_id      = aws_vpc.vpc_01.id
    ingress {
    description     = "no traffic "
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Private Security group"
  }
}
resource "aws_vpc" "vpc_01" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "central-network"
  }
}

resource "aws_subnet" "public-web-subnet-1" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}
resource "aws_subnet" "private-local-subnet-1" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private Subnet 1"
  }
}
resource "aws_eip" "eip_nat" {
  vpc = true
  tags = {
    Name = "eip1"
  }
}
resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-web-subnet-1.id
  tags = {
    "Name" = "nat1"
  }
}
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc_01.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Private Route Table"
  }
}
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.public-web-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.private-local-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name = "Test IGW"
  }
}

