resource "aws_security_group" "sg" {
    name = "sg"
    description = "sg"
    vpc_id = var.vpc_id

    tags = {
      Name = "sg"
    }

    ingress {
        from_port =  var.ssh_port
        to_port = var.ssh_port
        protocol = var.sg_proto
        cidr_blocks = var.sg_cidr
    }

    ingress {
        from_port =  var.http_port
        to_port = var.http_port
        protocol = var.sg_proto
        cidr_blocks = var.sg_cidr
    }

    egress {
        from_port = var.egress_port
        to_port = var.egress_port
        protocol = var.egress_proto
        cidr_blocks = var.sg_cidr
    }
}