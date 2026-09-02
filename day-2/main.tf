data "aws_vpc" "default" {
    default = true
}

resource "aws_security_group" "sg" {
    name = "security_gr"
    description = "my_group"
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "my-security-group"
     
}
}

resource "aws_instance" "server" {
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.Micro"
    key_name = "ubuntu"
    vpc_security_group_ids = ["aws_security_group.sg.id"]
    
    user_data = file("/root/Terraform-/day-2/user_data.sh")

    tags = {
        Name = "terraform-server"
    }
    root_block_device {
        volume_size = 16
        volume_type = "gp3"
    }
}