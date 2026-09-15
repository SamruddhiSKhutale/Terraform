resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc_samruddhii"
  }
}

resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.pub_subnet_cidr
  tags = {
    Name = "pub_subnet"
  }
}

resource "aws_internet_gateway" "igw_pub" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "igw_pub"
  }
}

resource "aws_route_table" "rt_pub" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_pub.id
  }
}

resource "aws_route_table_association" "subnet_ass_Sam" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.rt_pub.id
}
resource "aws_subnet" "priv_subnet" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = var.priv_subnet_cidr
  tags = {
    Name = "priv_subnet"
  }
}

resource "aws_eip" "eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_priv" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.pub_subnet.id
  tags = {
    Name = "nat_priv"
  }
}

resource "aws_route_table" "rt_priv" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_priv.id
  }

}

resource "aws_route_table_association" "subnet_ass_Sam_priv" {
  subnet_id      = aws_subnet.priv_subnet.id
  route_table_id = aws_route_table.rt_priv.id
}

resource "aws_security_group" "sg_samruddhii" {
  name        = "sg_samruddhii"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "server" {
  ami                    = "ami-0e34b50e714a297f1"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.pub_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_samruddhii.id]
}