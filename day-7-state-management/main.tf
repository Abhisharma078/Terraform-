resource "aws_s3_bucket" "s3" {
    bucket = "abhicloud.online"

    tags = {
      Name = "s3"
    }
}

resource "aws_instance" "public_server" {
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"
    key_name = "ubuntu"
    count = 2

    tags = {
      Name = "public_server"
    }
}

