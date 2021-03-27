output "repo_url" {
  description = "Get AWS ECR URL"
  value       = aws_ecr_repository.ecr.repository_url
}