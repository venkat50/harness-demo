resource "aws_s3_bucket" "example" {
   bucket = var.my_bucket
   acl = "public-read-write"
   tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

