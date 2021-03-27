output "bucket" {
  description = "Get S3 backend bucket"
  value       = aws_s3_bucket.backend.bucket
}

output "dynamodb_table" {
  description = "Get dynamodb_table backend lock"
  value       = aws_dynamodb_table.backend.name
}