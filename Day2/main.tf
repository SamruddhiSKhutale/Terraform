resource "aws_vpc" "sam_vpc" {
    cidr_block = var.vpc_cidr
    tags ={
        Name ="sam_vpc"
    }
}
resource "aws_subnet" "sam_subnet" {
    vpc_id = aws_vpc.sam_vpc.id
    cidr_block = var.subnet_cidr
    tags ={
        Name ="sam_subnet"
    }
}

resource "aws_security_group" "sam_sg" {
    name = "sam_sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.sam_vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}