provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "ec-create" {
  ami           = "ami-0b4c7755cdf0d9219"
  instance_type = "t2.micro"

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