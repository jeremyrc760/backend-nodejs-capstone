resource "aws_ssm_parameter" "mongodb_url" {
  name        = "/${var.project_name}/backend/mongodb_url"
  description = "MongoDB Atlas connection string for the backend."
  type        = "SecureString"
  value       = var.mongodb_url

  tags = {
    Project = var.project_name
    Managed = "terraform"
  }
}

resource "aws_ssm_parameter" "jwt_secret" {
  name        = "/${var.project_name}/backend/jwt_secret"
  description = "JWT signing secret for the backend."
  type        = "SecureString"
  value       = var.jwt_secret

  tags = {
    Project = var.project_name
    Managed = "terraform"
  }
}