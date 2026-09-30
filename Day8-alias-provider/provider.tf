provider "aws" {
    region = "us-east-1"
    alias = "dev"
    profile = "dev_profile"
}

provider "aws" {
    alias = "test"
    region = "us-west-1"
    profile = "test_profile"
}