# Lookup subnet by tag
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["dev"]   # change this to match your subnet tag
  }
}

# Lookup the latest Amazon Linux 2 AMI
data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Launch EC2 instance
resource "aws_instance" "example" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected.id

  tags = {
    Name = "example-instance"
  }
}
