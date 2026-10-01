module "gitsource" {
    source = "github.com/SamruddhiSKhutale/Terraform/Day6-modules"
    ami = "ami-0b245cc5f82576748"
    instance_type = "t2.micro"
  
}