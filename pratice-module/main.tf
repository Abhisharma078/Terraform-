module "vpc" {

    source = "./moodule/vpc"
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