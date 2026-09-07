resource "aws_instance" "public" {
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids = [var.server_sg]
    subnet_id = var.public_sb_id
    associate_public_ip_address = true
    
    user_data = file("/root/Terraform-/day-6-terraform.tfvars/module/ec2/user_data.sh")

    tags = {
      Name = "public"
    }
}

resource "aws_instance" "private" {
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids = [var.server_sg]
    subnet_id = var.private_sb_id
    associate_public_ip_address = false

    tags = {
      Name = "private"
    }
}