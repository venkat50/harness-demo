# Terraform configuration

provider "aws" {
  region = var.minio_region
  access_key = var.minio_access_key
  secret_key = var.minio_secret_key
  skip_credentials_validation = true
  skip_requesting_account_id = true
  s3_force_path_style     = true
  endpoints {
   s3 = var.minio_server
  }
}

