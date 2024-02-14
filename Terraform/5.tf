provider "aws"{
    region = "us-east-2"
    access_key = "AKIA5XB3OVIEMFVRVNJ6"
    secret_key = "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"
}
 
resource "aws_instance" "assignmnet-5-instance" {
    ami = "ami-05fb0b8c1424f266b"
    instance_type = "t2.micro"
    key_name = "terraform-Key"
    user_data = "${file("install-apache2.sh")}"
    tags = {
    Name = "assignmnet-5-instance"
    }
}
 
output "IPv4" {
    value = aws_instance.assignmnet-5-instance.public_ip
}
