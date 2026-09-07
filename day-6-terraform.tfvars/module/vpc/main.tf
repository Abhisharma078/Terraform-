resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.public_az
    cidr_block = var.public_cidr
    map_public_ip_on_launch = true

    tags = {
      Name = "public_subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.private_az
    cidr_block = var.private_cidr

    tags = {
        Name = "private_subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "igw"
    }
}

resource "aws_eip" "nat_eip" {
    domain = var.domain

    tags = {
      Name = nat_eip
    }
}

resource "aws_nat_gateway" "nat" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.eip.id

    tags = {
        Name = "nat"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.route_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_rt"
    }
}

resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt 
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.route_cidr
        nat_gateway_id = aws_nat_gateway.nat.id
    }
}

resource "aws_route_table_association" "private_rt-assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "sg" {
    name = var.sg_name
    description = var.sg_name
    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = var.sg_protocol
        cidr_blocks = var.sg_cidr
    }
    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = var.sg_protocol
        cidr_blocks = var.sg_cidr
    }
    egress {
        from_port = var.egress_port
        to_port = var.egress_port
        protocol = var.egress_protocol
        cidr_blocks = var.sg_cidr
    }
}


