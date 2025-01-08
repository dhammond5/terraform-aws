data "aws_ami" "ubuntu_east-1" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical (Ubuntu)
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_caller_identity" "current" {}

data "aws_region" "current" {}



output "ubuntu_east-1" {
  value = data.aws_ami.ubuntu_east-1.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

data "aws_vpc" "managed-console" {

  tags = {
    Env = "prod"
  }
}

output "managed-console-vpc" {
  value = data.aws_vpc.managed-console.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

output "available-azs" {
  value = data.aws_availability_zones.available
}

data "aws_iam_policy_document" "s3" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::*/*"]
  }
}

resource "aws_s3_bucket" "everyone_bucket" {
  bucket = "everyone_read_bucket"
}

output "s3_iam_policy" {
  value = data.aws_iam_policy_document.s3.json
}


# Ubuntu AMI ID = ami-095a8f574cb0ac0d0
# NGINX AMI ID = ami-0b2dc425776bf42c5

resource "aws_instance" "ubuntu_east-1" {
  ami                         = data.aws_ami.ubuntu_east-1.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
}