resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags ={
        key = "test"
    }
  
}
resource "aws_s3_bucket" "bucket" {
    bucket = "my-terraform-bucket-samruddhii"
    
}