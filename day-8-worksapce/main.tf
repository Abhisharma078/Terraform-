resource "aws_instance" "public" {
    ami = "ami-01a00762f46d584a1"
    key_name = "ubuntu"
    instance_type = "t3.micro"

    tags = {
      Name = "public"
    }

}