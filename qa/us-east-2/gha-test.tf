resource "aws_vpc" "qa" {
  cidr_block = "10.11.0.0/16"
  tags = {
    Name        = "qa_vpc"
    Environment = "qa"
  }
}


resource "aws_s3_bucket" "example" {
  bucket = "example"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id
  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}