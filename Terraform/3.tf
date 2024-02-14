provider "aws" {
    alias = "NV"
    region = "us-east-1"
    access_key = "AKIA5XB3OVIEMFVRVNJ6"
    secret_key = "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"
}
provider "aws" {
    alias = "Ohio"
    region = "us-east-2"
    access_key = "AKIA5XB3OVIEMFVRVNJ6"
    secret_key = "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"
}
resource "aws_instance" "assignment-3-1" {
    provider = aws.NV
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"
    key_name = "ansiblekp"
    tags = {
    Name = "hello-virginia"
    }
}
resource "aws_instance" "assignment-3-2" {
    provider = aws.Ohio
    ami = "ami-05fb0b8c1424f266b"
    instance_type = "t2.micro"
    key_name = "terraform-Key"
    tags = {
    Name = "hello-ohio"
    }
}
