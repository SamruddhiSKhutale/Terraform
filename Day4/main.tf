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
    bucket = "sam-bucket-terraform-uniqueeeeeeeeeeeeeee"
    tags = {
        Name = "sam_bucket"
    }
}
resource "aws_db_instance" "sam_rds" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"

  db_name  = "samdb"
  username = "admin"
  password = "Samruddhii123"

  parameter_group_name = "default.mysql8.0"

  skip_final_snapshot = true
  publicly_accessible = true
}
