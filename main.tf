provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "ec-create" {
  ami           = "ami-0b4c7755cdf0d9219"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "Node-Created-By-GitAction"
  }

}

terraform {
  backend "s3" {
    bucket = "jonag-terraform-store"
    key    = "cicd-project/terraform.tfstate"
    region = "eu-west-2"
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}
