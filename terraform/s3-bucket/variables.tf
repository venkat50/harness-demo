# Input variable definitions

variable "minio_region" {
 default = "us-east-1"
}

variable "minio_server" {
 default = "172.28.128.12:9000"
}

variable "minio_access_key" {
  default = "minio"
}

variable "minio_secret_key" {
 default = "minio123"
}
