resource "aws_s3_bucket" "example" {
   bucket = var.my_bucket
   acl = "public-read-write"
   tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.example.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": {
           "AWS": "*"
           },
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:::${var.my_bucket}/*"
    }
   ]
}
POLICY
}
 

