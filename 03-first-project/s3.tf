resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "don-2-bucket" {
  bucket = "don-2-bucket-${random_id.bucket_suffix.hex}"
}


resource "aws_s3_bucket" "don-west-bucket" {
  bucket = "don-west-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.don-2-bucket.bucket
}