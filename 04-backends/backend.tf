terraform {
  backend "s3" {
    bucket = "don-3-bucket"
    key    = "04-backends/dev/state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east"
}