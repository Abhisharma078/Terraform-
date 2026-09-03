resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.publice_az
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.private_az
    map_public_ip_on_launch = false
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
    domain = "vpc"
    tags = {
        Name = "nat_eip"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "nat_gateway"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public_rt"
    }
}
resource "aws_route_table_association" "public_rt_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "private_rt"
    }
}

resource "aws_route_table_association" "private_rt_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc.id
    description = "my-sg"
    name = "my-sg"

    ingress {
        from_port = 22
        to_port =22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = true
    user_data = file("/root/Terraform-/day-3/user_data.sh")

    root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
    }
    tags = {
        Name = "web"
    }
}

resource "aws_instance" "ec2" {
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.private_subnet.id

   tags = {
     Name = "ec2"
   }

    root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
    }
}




