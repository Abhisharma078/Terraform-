output "public_ip" {
    value = aws_instance.web.public_ip
}

output "private_ip" {
    value = aws_instance.ec2.private_ip
}

output "elastic_ip" {
    value = aws_eip.nat_eip.public_ip
}

output "sg_id" {
    value = aws_security_group.sg.id
}