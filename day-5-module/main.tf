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

module "ec2" {
    source = "./module/ec2"
    type = "t3.micro"
    key_name = "ubuntu"
    sg = module.vpc.sg_id
    ami = "ami-01a00762f46d584a1"
    subnet = module.vpc.subnet_id
}