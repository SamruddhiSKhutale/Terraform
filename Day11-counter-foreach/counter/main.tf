variable "tag" {
    default = ["dev", "prod"]
    type = list(string)
  
}

resource "aws_instance" "name" {
  ami = "ami-0d27e0fb3bac4d724"
  instance_type = "t2.micro"
  count = length(var.tag)
  tags = {
    Name = var.tag[count.index]
  }

}