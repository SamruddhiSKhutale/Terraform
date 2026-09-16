terraform {
  backend "s3" {
    bucket = "sam-bucket-terraform-unique"
    key    = "Day4/terraform.tfstate"
    region = "us-east-1"
  }
}