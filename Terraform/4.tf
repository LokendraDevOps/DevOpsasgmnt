provider "aws"{
    region = "us-east-2"
    access_key = "AKIA5XB3OVIEMFVRVNJ6"
    secret_key = "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"
}
 
resource "aws_instance" "assignment-4" {
    ami = "ami-05fb0b8c1424f266b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.assignment-4-subnet.id
    key_name = "terraform-Key"
    tags = {
    Name = "assignment-4"
    }
}
 
resource "aws_vpc" "assignment-4-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
    Name = "assignment-4-vpc"
    }
}
 
resource "aws_subnet" "assignment-4-subnet" {
    vpc_id = aws_vpc.assignment-4-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    tags = {
    Name = "assignment-4-subnet"
    }
}
