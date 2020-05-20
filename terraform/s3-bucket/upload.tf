resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "samplekey"
  source = "sample.txt"
  acl = "public-read"

}
