export MINIO_ACCESS_KEY="minio"
export MINIO_SECRET_KEY="minio123"
terraform init \
   -backend-config="access_key=$MINIO_ACCESS_KEY"  \
   -backend-config="secret_key=$MINIO_SECRET_KEY" 
