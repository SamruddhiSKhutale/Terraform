resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
 tags = {
         Name = "terraform-vpc"
        }
}

resource "aws_s3_bucket" "my_bucket"{
    bucket = "my-bucket-name-is-samruddhii"
}


resource "aws_instance" "my_ec2" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"              

  tags = {
    Name = "Samruddhi-EC2"
  }
}




