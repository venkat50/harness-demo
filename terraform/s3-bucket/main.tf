# Terraform configuration

provider "aws" {
  region = "us-east-1"
  access_key = "minio"
  secret_key = "minio123"
  skip_credentials_validation = true
  skip_requesting_account_id = true
  s3_force_path_style     = true
  endpoints {
   s3 = "http://172.28.128.12:30837"
  }
}

