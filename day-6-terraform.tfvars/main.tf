module "vpc" {
    source = "./module/vpc"
    vpc_cidr = var.vpc_cidr
    public_cidr = var.public_cidr
    public_az = var.public_az
    private_cidr = var.private_cidr
    private_az = var.private_az
    domain = var.domain
    route_cidr = var.route_cidr
    ssh_port = var.ssh_port
    http_port = var.http_port
    sg_protocol = var.sg_protocol
    sg_cidr = var.sg_cidr
    egress_port = var.egress_port
    egress_protocol = var.egress_protocol
    sg_name = var.sg_name
}


module "ec2" {
    source = "./module/ec2"
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    server_sg = module.vpc.sg.sg_id
    public_sb_id = module.vpc.public_subnet_id
    private_sb_id = module.vpc.private_subnet_id
}
