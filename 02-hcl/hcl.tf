terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.37"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east"
}

# Managed by Terraform
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Managed somewhere else, used for the project
data "aws_s3_bucket" "external_bucket" {
  bucket = "outside_terraform_bucket"
}

variable "bucket_name" {
  type        = string
  description = "variable used to set bucket name"
  default     = "default_bucket"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

locals {
  Local_bucket = "This is a local bucket"
}

