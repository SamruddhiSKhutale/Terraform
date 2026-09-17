resource "aws_vpc" "sam_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sam_vpc"
  }
}

resource "aws_subnet" "sam_subnet_1" {
  vpc_id            = aws_vpc.sam_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name = "sam_subnet_1"
  }
}

resource "aws_subnet" "sam_subnet_2" {
  vpc_id            = aws_vpc.sam_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "sam_subnet_2"
  }
}

resource "aws_security_group" "sam_sg" {
  name        = "sam_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.sam_vpc.id

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

resource "aws_db_subnet_group" "my_subnet_group" {
  name = "my-db-subnet-group"

  subnet_ids = [
    aws_subnet.sam_subnet_1.id,
    aws_subnet.sam_subnet_2.id
  ]

  tags = {
    Name = "my-db-subnet-group"
  }
}

resource "aws_db_instance" "primary_db" {
  identifier        = "primary-db"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "primarydb"
  username = "admin"
  password = "Samruddhik14"

  db_subnet_group_name   = aws_db_subnet_group.my_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sam_sg.id]

  publicly_accessible = false

  skip_final_snapshot = true
}