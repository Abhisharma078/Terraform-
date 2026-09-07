vpc_cidr = "10.0.0.0/16"
public_cidr = "10.0.0.0/20"
public_az = "ap-south-1a"
private_cidr = "10.0.16.0/20"
private_az = "ap-south-1a"
domain = "vpc"
route_cidr = "0.0.0.0/0"
ssh_port = 22
http_port = 80
sg_protocol = "tcp"
sg_cidr = ["0.0.0.0/0"]
egress_port = 0
egress_protocol = "-1"
sg_name = "sg"

ami = "ami-01a00762f46d584a1"
key_name = "ubuntu"
instance_type = "t3.micro"