provider "aws"{
    region = "us-east-2"
    access_key = "AKIA5XB3OVIEMFVRVNJ6"
    secret_key = "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"
}

resource "aws_instance" "assignment-2" {
    ami = "ami-05fb0b8c1424f266b"
    instance_type = "t2.micro"
    key_name = "terraform-Key"
    tags = {
    Name = "assignment-2"
    }
}

resource "aws_eip" "eip" {
    vpc = true
}

resource "aws_eip_association" "eip_assoc" {
    instance_id   = aws_instance.assignment-2.id
    allocation_id = aws_eip.eip.id
}
