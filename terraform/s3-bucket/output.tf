output "my_url" {
  value = "${var.minio_server}/${var.my_bucket}/${var.my_file}"
}
