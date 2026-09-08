resource "aws_instance" "public_server" {
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"
    key_name = "ubuntu"
    count = 2
    vpc_security_group_ids = ["sg-02f87d7e6f3905dc3"]

    tags = {
      Name = "public_server"
    }
}

