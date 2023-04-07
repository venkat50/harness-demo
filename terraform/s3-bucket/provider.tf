provider "aws" {
  region = var.minio_region
  access_key = var.minio_access_key
  secret_key = var.minio_secret_key
  s3_use_path_style     = true
  endpoints {
   s3 = var.minio_server
  }
  # Make it faster by skipping something
 
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}
