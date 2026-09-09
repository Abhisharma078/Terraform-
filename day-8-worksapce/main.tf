resource "aws_instance" "public" {
    ami = ""
    key_name = "ubuntu"
    instance_type = "t3.micro"

    tags = {
      Name = "public"
    }

}