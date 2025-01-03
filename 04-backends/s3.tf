resource "aws_s3_bucket" "don-3-bucket" {
  bucket = "don-3-bucket"
}


resource "aws_s3_bucket" "don-west-2-bucket" {
  bucket = "don-west-2-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.don-3-bucket.bucket
}