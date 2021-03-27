resource "random_id" "ecr" {
  byte_length = 8
}


resource "aws_ecr_repository" "ecr" {
  name                 = "ecr${random_id.ecr.dec}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

}