variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = ""
}

variable "pub_subnet_cidr" {
    description = "CIDR block for the public subnet"
    default = ""
}

variable "priv_subnet_cidr" {
    description = "CIDR block for the private subnet"
    default = ""
}
