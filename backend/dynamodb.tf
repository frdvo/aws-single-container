resource "aws_dynamodb_table" "backend" {
  name           = "terraform-backend-s3-${random_id.backend.dec}"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

}