module "network" {
    source = "../../modules/network"
    vpc_cidr = "10.0.0.0/24"
    subnet_cidr = "10.0.0.0/24"
    providers = {
        aws = aws.test
    } 
}

module "compute" {
    source = "../../modules/compute"
    ami = "ami-0b245cc5f82576748"
    instance_type = "t2.micro"
    subnet_id = module.network.subnet_id
    providers = {
    aws = aws.test
    }
}