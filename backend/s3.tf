resource "aws_s3_bucket" "backend" {
  bucket = "terraform-backend-s3-${random_id.backend.dec}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

}