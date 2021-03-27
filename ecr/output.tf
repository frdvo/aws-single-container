output "ecr" {
  description = "Get AWS ECR URL"
  value = {
    repository_url = aws_ecr_repository.ecr.repository_url
  }
}