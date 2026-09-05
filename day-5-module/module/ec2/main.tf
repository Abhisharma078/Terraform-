resource "aws_instance" "ec2" {
    instance_type = var.type
    key_name = var.key_name
    vpc_security_group_ids = var.sg
    subnet_id = var.subnet
    user_data = filebase64("/root/Terraform-/day-5-module/module/ec2/user_data.sh")
    
}