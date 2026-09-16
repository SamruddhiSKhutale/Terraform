resource "aws_vpc" "sam_vpc" {
    cidr_block = var.vpc_cidr
    tags ={
        Name ="sam_vpc"
    }
}

resource "aws_subnet" "pub_subnet" {
    vpc_id     = aws_vpc.sam_vpc.id
    cidr_block = var.pub_subnet_cidr
    tags = {
        Name = "pub_subnet"
    }
}

resource "aws_instance" "sam_instance" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = aws_subnet.pub_subnet.id
    tags = {
        Name = "sam_instance"
    }
}


resource "aws_s3_bucket" "sam_bucket" {
    bucket = "sam-bucket-terraform-unique"
    tags = {
        Name = "sam_bucket"
    }
}