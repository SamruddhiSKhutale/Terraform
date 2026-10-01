resource "aws_instance" "server" {
   ami = "ami-0b245cc5f82576748"
  instance_type = "t3.micro"
  tags = {
    Name = "server"
  }
}

 #terraform import aws_instance.dev i-0d4816902c22eed9e
# ami = "ami-0fef201115eefe936"
#   instance_type = "t2.medium"
#   tags = {
#     Name = "ec2"
#   }
resource "aws_s3_bucket" "name" {
    bucket = "test-devtest-veera"
  
}
resource "aws_s3_bucket_versioning" "example_versioning" {
  bucket = aws_s3_bucket.name.id

  versioning_configuration {
    status = "Enabled"
  }
}