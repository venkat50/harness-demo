# Terraform configuration

terraform {
   backend "s3" {
     endpoint = "http://172.28.128.12:30837"
     bucket  = "tfstate"
     key = "terraform.tfstate"
     region = "us-east-1"
     force_path_style  = true
     skip_credentials_validation = true
     skip_metadata_api_check = true
  }
}

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


