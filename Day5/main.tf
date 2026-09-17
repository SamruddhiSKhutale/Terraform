resource "aws_vpc" "sam_Vpc" {
  cidr_block = "10.0.0.0/16"
  tags ={
    Name = "sam_Vpc"
  }
}

resource "aws_subnet" "sam_Subnet" {
  vpc_id = aws_vpc.sam_Vpc.id
  cidr_block = "10.0.1.0/24"
  tags ={
    Name = "sam_Subnet"
  }
}

resource "aws_instance" "sam_ec2" {
  ami = "ami-0e34b50e714a297f1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sam_Subnet.id
  tags ={
    Name = "sam_ec2"
  }
}




