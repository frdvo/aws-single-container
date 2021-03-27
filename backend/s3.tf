resource "aws_s3_bucket" "backend" {
  bucket = "terraform-backend-s3-${random_id.backend.hex}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

}