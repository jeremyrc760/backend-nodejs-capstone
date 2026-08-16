output "backend_ecr_repository_url" {
  description = "ECR repository URL for the backend Docker image."
  value       = aws_ecr_repository.backend.repository_url
}

output "frontend_ecr_repository_url" {
  description = "ECR repository URL for the frontend image."
  value       = aws_ecr_repository.frontend.repository_url
}

output "backend_alb_dns_name" {
  description = "Public DNS name of the backend Application Load Balancer."
  value       = aws_lb.backend.dns_name
}

output "backend_url" {
  description = "HTTP URL for the backend service."
  value       = "http://${aws_lb.backend.dns_name}"
}