resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "vpc"
    }
}

resource "aws_subnet" "public_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.public1_az
    cidr_block = var.public1_cidr
    map_public_ip_on_launch = true

    tags = {
      Name = "public_subnet_1a"
    }
}

resource "aws_subnet" "public_subnet_2b" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.public1_az
    cidr_block = var.public2_cidr
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_2b"
    }
}

resource "aws_subnet" "private_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.private1_az
    cidr_block = var.private1_cidr
   
    tags = {
        Name = "private_subnet_2a"
    }
}

resource "aws_subnet" "private_subnet_2b" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = var.private2_az
    cidr_block = var.private2_cidr
   
    tags = {
        Name = "private_subnet_2b"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "nat_eip" {
    domain = var.domain_name

    tags = {
      Name = "nat_eip"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet_1a.id

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

resource"aws_route_table_association" "public_ass_1a" {
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet_1a.id
}

resource "aws_route_table_association" "public_ass_2b" {
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet_2b.id 
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    route = {
        cidr_block = var.route_cidr
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
      Name = "priavte_rt"
    }
}

resource"aws_route_table_association" "private_ass_1a" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet_1a.id
}

resource"aws_route_table_association" "private_ass_2b" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet_2b.id
}