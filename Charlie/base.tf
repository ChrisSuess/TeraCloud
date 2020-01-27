provider "aws" {
  profile    = "default"
  region     = "eu-west-1"
}

data "aws_ami" "base" {
  most_recent = true
  owners = [data.aws_caller_identity.current.account_id]
  filter {
    name = "name"
    values = ["*xbow-packer-*"]
  }
}

data "aws_caller_identity" "current" {}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = file("terraform_ec2_key.pub")
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow ssh access from anywhere"
  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "xbow_bucket" {
  bucket = "laughtongroup.charlie.xbow"
  acl = "private"
}

