# Input variable definitions

variable "minio_region" {
 default = "us-east-1"
}

variable "minio_server" {
 default = "http://172.28.128.12:30837"
}

variable "minio_access_key" {
  default = "minio"
}

variable "minio_secret_key" {
 default = "minio123"
}

variable "my_bucket" {
 default = "my-bucket-0520"
}

variable "my_file" {
 default = "sample.txt"
}
