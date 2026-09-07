module "vpc" {

    source = "./module/vpc"
    vpc_cidr = "10.0.0.0/16"
    public1_az = "ap-south-1a"
    public1_cidr = "10.0.0.0/20"
    public2_az = "ap-south-1b"
    public2_cidr = "10.0.16.0/20"
    private1_az = "ap-south-1a"
    private1_cidr = "10.0.32.0/20"
    private2_az = "ap-south-1b"
    private2_cidr = "10.0.48.0/20"
    domain_name = "vpc"
    route_cidr = "0.0.0.0/0"
}

module "sg" {
    source = "./module/security-group-sg"
    vpc_id = module.vpc.vpc_id
    ssh_port = 22
    sg_proto = "tcp"
    sg_cidr = ["0.0.0.0/0"]
    http_port = 80
    egress_port = 0
    egress_proto = "-1" 
}