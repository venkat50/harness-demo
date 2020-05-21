resource "aws_s3_bucket_object" "myobject" {
  bucket = aws_s3_bucket.example.id
  key    = "${var.my_file}"
  source = "${var.my_file}"
  acl = "public-read-write"

}
