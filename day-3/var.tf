variable vpc_cidr {
    default = "10.0.0.0/16"
}

variable public_subnet_cidr {
    default = "10.0.0.0/20"
}

variable private_subnet_cidr {
    default = "10.0.16.0/20"
}

variable instance_type {
    default = "t3.micro"
}

variable ami {
    default = "ami-01a00762f46d584a1"
}

variable key_name {
    default = "abhi"
}

variable volume_size {
    default = 10
}

variable volume_type {
    default = "gp3"
}

variable publice_az {
    default = "ap-south-1a"
}

variable private_az {
    default = "ap-south-1b"
}







