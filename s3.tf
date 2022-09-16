resource "aws_s3_bucket" "change-123" {
  bucket = "change-123"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "chandra" {
  bucket = aws_s3_bucket.change-123.id
  acl    = "private"
}