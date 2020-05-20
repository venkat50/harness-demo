resource "aws_s3_bucket" "example" {
   bucket = var.my_bucket
   acl = "public"
   tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
