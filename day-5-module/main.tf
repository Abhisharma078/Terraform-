module "vpc" {
    source = "./module/vpc"
    vpc_cidr = "10.0.0.0/16"
    public_cidr = "10.0.0.0/20"
    public_az = "ap-south-1a"
    private_cidr = "10.0.16.0/20"
    private_az = "ap-south-1b"
    sg_name = "sg"
    http_port = 80
    ssh_port = 22
}