resource "aws_vpc" "samruddhi_vpc"{
    cidr_block = "10.0.0.0/16"
    tags ={
        Name ="sam_vpc"
 }
}

resource "aws_subnet" "samruddhi_subnnet1" {
    vpc_id = aws_vpc.samruddhi_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  tags = {
        Name = "sam_subnet"
        
    }
}
 resource "aws_subnet" "samruddhi_subnnet2" {
    vpc_id = aws_vpc.samruddhi_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
  tags = {
        Name = "sam_subnet"
        
    }
}

resource "aws_internet_gateway" "samruddhi_igw" {
    vpc_id = aws_vpc.samruddhi_vpc.id
  tags = {
        Name = "sam_igw"
        
    }
}

resource "aws_nat_gateway" "samruddhi_nat" {
    subnet_id = aws_subnet.samruddhi_subnnet1.id
    allocation_id = aws_eip.samruddhi_eip.id
    tags ={
        name = "sam_nat"
    }
}

resource "aws_eip" "samruddhi_eip" {
    domain = "vpc"
  tags ={
        name = "sam_eip"
    }
}

resource "aws_route_table" "samruddhi_route_table" {
    vpc_id = aws_vpc.samruddhi_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
         gateway_id = aws_internet_gateway.samruddhi_igw.id
    }
  tags = {
        Name = "sam_route_table"
        
    }
}

resource "aws_route_table_association" "samruddhi_route_table_association1" {
    subnet_id = aws_subnet.samruddhi_subnnet1.id
    route_table_id = aws_route_table.samruddhi_route_table.id
}

resource "aws_route_table" "samruddhi_pvt_route_table" {
    vpc_id = aws_vpc.samruddhi_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.samruddhi_nat.id
    }
  tags = {
        Name = "sam_pvt_route_table"
        
    }
}

resource "aws_route_table_association" "samruddhi_route_table_association2" {
    subnet_id = aws_subnet.samruddhi_subnnet2.id
    route_table_id = aws_route_table.samruddhi_pvt_route_table.id
}





