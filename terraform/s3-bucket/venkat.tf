data "aws_s3_bucket" "venkat" {
  bucket = "venkat-example-2020-05-17"
}
output "venkat_id" {
  value = data.aws_s3_bucket.venkat.id
}

output "venkat_region" {
  value = data.aws_s3_bucket.venkat.region
}

output "venkat_arn" {
  value = data.aws_s3_bucket.venkat.arn
}
