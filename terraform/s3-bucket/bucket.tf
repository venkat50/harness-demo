resource "aws_s3_bucket" "example" {
   bucket = "venkat-example-2020-05-17"
   acl = "public"
   tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
