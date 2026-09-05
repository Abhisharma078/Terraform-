resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_cidr
    availability_zone = var.public_az
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    cidr_block = var.private_cidr
    availability_zone = var.private_az
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "private_subnet"
    }
}

resource "aws_internt_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

   tags = {
    Name = "igw"
   }
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
        Name = "nat_eip"
    }
}

resource "aws_nat_gateway" "nat" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.nat_eip.id

    tags = {
        Name = "nat"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway_igw.id
    }
    tags = {
        Name = "public_rt"
    }
}

resource "aws_route_table_assocation" "public_rt" {
    subnet_id = aws_subent.public_subent.id
    route_table_id = aws_route_table.public_rt.id
}
  
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        nat_gateway_id = aws_nat_gateway.nat.id
        cidr_block = "0.0.0.0/0"
    } 
    tags = {
        Name = "private_rt"
    }
}

resource "aws_route_table_assocation" "private_rt" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.praivate_rt.id
}

resource "aws_security_group" "sg" {
    name = var.sg_name
    description = "sg"
    vpc_id = aws_vpc.vpc.id

    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }

    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = "0.0.0.0/0"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
    }
}



