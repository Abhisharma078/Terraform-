output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnet_1a_id" {
    value =  module.vpc.public_subnet_1a
}

output "public_subnet_2b_id" {
    value =  module.vpc.public_subnet_2b
}

output "private_subnet_1a_id" {
    value =  module.vpc.private_subnet_1a
}

output "private_subnet_2b_id" {
    value =  module.vpc.private_subnet_2b
}
